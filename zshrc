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
alias v='vim'
alias nv='nvim'

# Prompt
eval "$(starship init zsh)"

# Delete key
bindkey "^[[3~" delete-char

# Variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export GOPRIVATE=github.com/

# NNN configuration
# export NNN_COLORS="0000"
export NNN_FCOLORS="0000"
# export LS_COLORS=""
export NNN_ICONS=1
export NNN_ICONLOOKUP=1
export NNN_USE_EDITOR=1
export NNN_OPTS="ade"

# SSH
eval $(keychain --eval --quiet id_ed25519)

# Tmux
if [ -z "$TMUX" ] && [ -n "$PS1" ] && [[ "$(tty)" == /dev/pts/* ]]; then
    exec tmux
fi
