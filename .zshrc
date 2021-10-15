source /usr/local/share/zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


zinit wait lucid light-mode for \
    OMZL::clipboard.zsh \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::functions.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::misc.zsh \
    OMZL::termsupport.zsh \
    OMZP::autojump \
    OMZP::git \
    atinit"zicompinit; zicdreplay" OMZP::kubectl \
    OMZP::tmux

zinit wait lucid light-mode for \
    zsh-users/zsh-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions

zinit ice wait lucid multisrc'shell/{key-bindings,completion}.zsh'
zinit light junegunn/fzf

zinit load mafredri/zsh-async
zinit load sindresorhus/pure
RPROMPT='%F{8}%*'

# Load aliases
[ -s "$HOME/.aliases" ] && source $HOME/.aliases
[ -s "$HOME/.aliases-custom" ] && source $HOME/.aliases-custom

# KeyBindings
bindkey '^P' up-line-or-search # make ctrl+p behave same as up arrow

# Use ~~ to trigger autocompletion (instead of **)
export FZF_COMPLETION_TRIGGER='~~'

# do not quit shell when Ctrl+D is registered
set -o ignoreeof

# Avoid issues with `gpg` as installed via Homebrew.
# # https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)
# The terminal in tmux in kitty did not render characters correctly. This fixed
# that see link below for details
# https://github.com/sindresorhus/pure/issues/300#issuecomment-386371460
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

[ -f ~/.zshrc-custom.zsh ] && source ~/.zshrc-custom.zsh
