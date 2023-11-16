#!/usr/bin/env bash
fileName="ksmserverrc"
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

startDelete=`grep -n "LegacySession" $fileName -m 1 | cut -d: -f1`
stopDelete=`wc -l $fileName | cut -d " " -f1`
sed "${startDelete},${stopDelete}d" $fileName > konsave-filtered-file.$fileName 

mv konsave-filtered-file.$fileName $fileName
echo "$fileName hook finished!"
