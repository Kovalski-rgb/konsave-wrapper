installDir="~/.config/konsave/"
if grep -Fq "konsave()" ~/.zshrc ; then
  echo "konsave reference is already on zshrc!"
else
  echo -e "konsave() {\n      ${installDir}konsave-wrapper/starter.sh \$@\n}" >> ~/.zshrc
fi
if grep -Fq "konsave()" ~/.bashrc ; then
  echo "konsave reference is already on bashrc!"
else
  echo -e "konsave() {\n      ${installDir}konsave-wrapper/starter.sh \$@\n}" >> ~/.bashrc
fi
mkdir -p postHooks/
mkdir -p hooks/
eval mkdir -p "${installDir}" 

sed -i '2iinstallDir="'"${installDir}"'konsave-wrapper\"' starter.sh

eval mv "../konsave-wrapper ${installDir}" 

echo "konsave-wrapper installed at ${installDir}"
#eval rm "${installDir}installer.sh"
