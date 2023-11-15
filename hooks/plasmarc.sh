fileName="plasmarc"
echo "$fileName hook called!"
rootPath=
backupName=
while getopts 'r:n:' flag; do
  case "${flag}" in
    r) rootPath="$OPTARG";;
    n) backupName="$OPTARG";;
  esac
done


cd "$backupName/save/configs/"
sed -i 's/\/home\/\w*/\$HOME/g' $fileName
echo "$fileName hook finished!"
