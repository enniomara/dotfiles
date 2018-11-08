source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
# Syntax highlighting (green when command exists)
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Install pure theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

# Load aliases
source $HOME/.aliases

# Load Ctrl-R to reverse search command history using fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
