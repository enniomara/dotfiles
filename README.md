# Dotfiles

## How to install?

### Home Manager

Install Nix by running following the steps on the [NixOS website](https://nixos.org/download.html#nix-install-macos). 
Then install nix-darwin by following the instructions on its [Github page](https://github.com/LnL7/nix-darwin#install).

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

