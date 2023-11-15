fileName="bookmarks"
echo "gtk $fileName hook called!"
rootPath=
backupName=
while getopts 'r:n:' flag; do
  case "${flag}" in
    r) rootPath="$OPTARG";;
    n) backupName="$OPTARG";;
  esac
done


cd "$backupName/save/configs/gtk-3.0"
sed -i 's/\/home\/\w*/\$HOME/g' $fileName
echo "gtk $fileName hook finished!"
