# Dotfiles

## How to install?

### Vim

```
ln -s [path to dotfiles]/.vimrc ~/.vimrc
```
After that install VIM-Plug from [here](https://github.com/tomasiser/vim-code-dark).
Then run the following in vim.
```
:PlugInstall
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
