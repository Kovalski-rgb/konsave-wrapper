set -e
callPath=$PWD
kommand="/usr/bin/konsave"
helpRan=
exportDir=
exportName=
quietMode=
uninstall=
while [ $# -gt 0 ]; do
  case $1 in
        -h | --help) kommand="$kommand $1" helpRan="true" shift;;
        -l | --list) kommand="$kommand $1" shift;;
        -s | --save) kommand="$kommand $1 $2" shift 2;;
        -r | --remove) kommand="$kommand $1 $2" shift 2;;
        -a | --apply) kommand="$kommand $1 $2" shift 2;;
        -e | --export-profile) kommand="$kommand $1 $2"
             if [ -z "$exportDir" ]
             then
               exportDir="$PWD"
             fi
             if [ -z "$exportName" ]
             then
               exportName=$2
             fi
             shift 2
        ;;
        -i | --import-directory) kommand="$kommand $1 $2" shift 2;;
        -f | --force) kommand="$kommand $1" shift;;
        -d | --export-directory) exportDir=$2 shift 2;;
        -n | --export-name) kommand="$kommand $1 $2" exportName=$2 shift 2;;
        -v | --version) kommand="$kommand $1" shift;;
        -w | --wipe) kommand="$kommand $1" shift;;
        -q | --quiet) quietMode="> /dev/null" shift;;
        --uninstall) uninstall="true" shift;;
        *) shift ;; 
  esac
done

if [ -n "$uninstall" ]; then
  eval cd $installDir
  sed -i -e "/konsave()/,+2d" ~/.bashrc
  sed -i -e "/konsave()/,+2d" ~/.zshrc
  eval cd $callPath
  eval rm -rf $installDir
  exit 0
fi

# checks if its not a export command of any kind, if its not, just run the command normally
if [ -z "$exportDir" ]; then
  eval "$kommand"
  if [ -n "$helpRan" ]; then
    echo
    echo "Konsave-wrapper commands:"
    echo -e "  -q, --quiet\t\tCleans up the backup file quietly"
    echo -e "  --uninstall\t\tRemoves konsave-wrapper from your system"
  fi  
  exit 0
fi
eval cd $installDir 

# runs konsave command to export configs, disables output
echo "Creating backup file..."
eval "${kommand} > /dev/null"
echo "Backup file created!"

# extracts compressed export config to start cleanup, after extraction, removes original knsv file
mkdir $exportName
echo "Extracting backup file to start cleanup..."
unzip -q "$exportName.knsv" -d "./$exportName" 
echo "Extraction complete!"
rm -rf "$exportName.knsv"

# checks for hooks inside hook folder, skips if there are none, else run them
echo "Running cleanup hooks..."
if test -n "$(find ./hooks/ -maxdepth 0 -empty)" ;
then
  echo "No scripts in hooks folder, skipping..."
else
  for i in hooks/*.sh; do eval "./$i -r $PWD -n $exportName $quietMode"; done
  echo "Finished cleanup!"
fi

# same for postHook scripts
echo "Running postHook script..."
if test -n "$(find ./postHooks/ -maxdepth 0 -empty)" ;
then
  echo "No scripts in postHook folder, skipping..."
else
  for i in postHooks/*.sh; do eval "./$i -r $PWD -n $exportName $quietMode"; done
  echo "Finished running the postHook script!"
fi

# compresses the clean folder back to a zip with knsv extension
echo "Compressing clean backup..."
zip -r -q ${exportName}.knsv "./$exportName"
echo "Compressing done!"

# workfolder cleanup, sends knsv file to where the command was run
mv "$exportName.knsv" $exportDir/$exportName.knsv
rm -rf $exportName
echo "File saved at ${exportDir}"

cd "$callPath"
