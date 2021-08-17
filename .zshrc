source /usr/local/share/zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid light-mode for \
    zsh-users/zsh-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions

zinit wait lucid light-mode for \
    OMZL::directories.zsh \
    OMZL::key-bindings.zsh \
    OMZP::autojump \
    OMZP::git \
    OMZP::kubectl \
    OMZP::tmux


zinit load mafredri/zsh-async
zinit load sindresorhus/pure

# Load aliases
[ -s "$HOME/.aliases" ] && source $HOME/.aliases
[ -s "$HOME/.aliases-custom" ] && source $HOME/.aliases-custom

# KeyBindings
bindkey '^P' up-line-or-search # make ctrl+p behave same as up arrow

# Change color of zsh autosuggestion to dark grey
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# Use ~~ to trigger autocompletion (instead of **)
export FZF_COMPLETION_TRIGGER='~~'

# do not quit shell when Ctrl+D is registered
set -o ignoreeof

# Avoid issues with `gpg` as installed via Homebrew.
# # https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

# Load Ctrl-R to reverse search command history using fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zshrc-custom.zsh ] && source ~/.zshrc-custom.zsh
