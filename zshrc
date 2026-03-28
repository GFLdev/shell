# Compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/gfl/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit; prompt gentoo

# Plugins
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
source $HOME/Repos/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5c6773"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'

# Prompt
eval "$(starship init zsh)"

# Delete key
bindkey "^[[3~" delete-char

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Go private
GOPRIVATE=github.com/
