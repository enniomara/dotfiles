source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
# Syntax highlighting (green when command exists)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle autojump # enables autojump if installed

# Install pure theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

# Load aliases
[ -s "$HOME/.aliases" ] && source $HOME/.aliases

# KeyBindings
bindkey '^P' up-line-or-search # make ctrl+p behave same as up arrow

# Change color of zsh autosuggestion to dark grey
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# Use ~~ to trigger autocompletion (instead of **)
export FZF_COMPLETION_TRIGGER='~~'

# Load Ctrl-R to reverse search command history using fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f .zshrc-custom.zsh ] && source ~/.zshrc-custom.zsh
