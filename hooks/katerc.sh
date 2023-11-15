fileName="katerc"
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
sed -n '/\(Recent Files\)\|\(Recent URLs\)\|\(Replace History\)\|\(Search History=\)/!p' $fileName > konsave-filtered-file.$fileName
mv konsave-filtered-file.$fileName $fileName
echo "$fileName hook finished!"
