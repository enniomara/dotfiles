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
#### zshrc-custom
This file is used to add lines to zshrc that do not need to be versioned. Create and symlink it by running:
```
touch [path to dotfiles]/.zshrc-custom.zsh && ln -s [path to dotfiles]/.zshrc-custom.zsh ~/.zshrc-custom.zsh
```

#### Autojump

Install autojump by running. This is autoloaded into zsh by default. If it's
not installed the shell will show a warning.

```
brew install autojump
```

#### Aliases
Symlink the aliases file by running:

```
ln -s [path to dotfiles]/.aliases ~/.aliases
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
The Karabiner configuration is generated by a tool called [Goku](https://github.com/yqrashawn/GokuRakuJoudo), since the DSL it provides is much more friendly than the JSON used by Karabiner. To generate the configuration, and symlink it, run the following:

Make sure to remove the folder `~/.config/karabiner` before proceeding.

```shell
$ rm -r ~/.config/karabiner # delete the old karabiner configuration
$ ln -s [path to dotfiles]/misc/karabiner/ ~/.config/karabiner
$ brew install yqrashawn/goku/goku
$ goku -c ~/.config/karabiner/karabiner.edn
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

### BetterTouchTool3

Import the config in `misc/BetterTouchTool` by pressing preset then import.

https://community.folivora.ai/t/how-to-backup-import-btt-settings/9727

### Tmux

Install TPM from [here](https://github.com/tmux-plugins/tpm) and clone it to
the `~/.tmux/plugins/tpm`. Then symlink the conf files by running:

```
ln -s [path to dotfiles]/{.tmux.conf,.tmux-osx.conf} ~/
```

