# Dotfiles

## How to install?

### Vim

```
ln -s [path to dotfiles]/.vimrc ~/.vimrc
```
After that install VIM-Plug from [here](https://github.com/junegunn/vim-plug).
Then run the following in vim.
```
:PlugInstall
```

### ZSH
Make sure [Antigen] is installed https://github.com/zsh-users/antigen. Then make sure the antigen path in .zshrc
is correct.

After that run
```
ln -s [path to dotfiles]/.zshrc ~/.zshrc
```


### iTerm2
Can be done either by the gui or the terminal.

```
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "[path to dotfiles]/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```

### Karabiner
Make sure to remove the folder `~/.config/karabiner` before proceeding.

```
$ ln -s [path to dotfiles]/misc/karabiner ~/.config/karabiner
```

### cVim
Install cVim from [here](https://chrome.google.com/webstore/detail/cvim/ihlenndgcmojhcghmfjfneahoeklbjjh). 

Update `configpath` to reflect the location of `.cvimrc` file (in dotfiles
folder). Then load it on the browser by running `:source {$pathToCvimRC}`.

### Visual Studio Code
Install Visual Studio Code from [here](https://code.visualstudio.com/).

Find the setting file location from [here](https://code.visualstudio.com/docs/getstarted/settings#_settings-file-locations)

Symlink settings.json by running 
```
ln -s [path to dotfiles]/vscode/{settings.json,keybindings.json} [path to vscode settings.json]
```
