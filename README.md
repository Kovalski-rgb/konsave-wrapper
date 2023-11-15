# konsave-wrapper
a simple wrapper for konsave, for hook support

clone this project, then run the following command for the initial setup
### for bash users
```shell
echo "\nkonsave() {\n      ~/.config/konsave/konsave-wrapper/starter.sh $@\n}" >> ~/.bashrc && cd konsave-wrapper && mkdir -p ~/.config/konsave/konsave-wrapper && unzip -q konsave-wrapper.zip -d ~/.config/konsave/
```

### for zsh users
```shell
echo "konsave() {\n      ~/.config/konsave/konsave-wrapper/starter.sh $@\n}" >> ~/.zshrc && cd konsave-wrapper && mkdir -p ~/.config/konsave/konsave-wrapper && unzip -q konsave-wrapper.zip -d ~/.config/konsave/
```

All files will be stored under `.config/konsave/`
