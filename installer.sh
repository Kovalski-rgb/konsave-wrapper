installDir="~/.config/konsave/"
if grep -Fq "konsave()" ~/.zshrc ; then
  echo "konsave reference is already on zshrc!"
else
  echo -e "\nkonsave() {\n      ${installDir}konsave-wrapper/starter.sh \$@\n}" >> ~/.zshrc
fi
mkdir -p postHooks/
mkdir -p hooks/
eval mkdir -p "${installDir}" 
eval mv "../konsave-wrapper ${installDir}" 

echo "konsave-wrapper installed at ${installDir}"
eval rm "${installDir}/installer.sh"
