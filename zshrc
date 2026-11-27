# Compinit
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
setopt autocd extendedglob nomatch notify
setopt share_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/gfl/.zshrc'

autoload -Uz compinit promptinit
compinit
# promptinit; prompt gentoo

# Plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5c6773"

# fzf: Ctrl-R history search, Ctrl-T file picker, Alt-C cd
source <(fzf --zsh)

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias v='vim'
alias nv='nvim'
alias hypr='ck-launch-session dbus-run-session start-hyprland'
alias doas='doas '            # trailing space lets aliases expand after doas (e.g. `doas nv`)

# Navigation: `cd hypr` / `cd kitty` / `cd dwm` work from anywhere
cdpath=(~/.config ~/Repos ~)
hash -d hypr=~/.config/hypr   # with autocd, typing `~hypr` jumps there
hash -d nvim=~/.config/nvim
hash -d kitty=~/.config/kitty

# Shell config
alias ze='nvim ~/.zshrc'
alias zr='source ~/.zshrc'

# Git
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph -15'
alias gb='git branch'
alias gco='git checkout'

# gcm changed blur and opacity to match picom  ->  "changed: blur and opacity to match picom"
gcm() { git commit -m "$1: ${*:2}" }

# Add, commit and push in one step: gacp "changed: keyboard variant to us intl"
gacp() { git add -A && git commit -m "$*" && git push }

# Set up a new dotfiles repo: ginit kitty
ginit() {
  git init && git branch -M main &&
  git remote add origin "git@github.com:GFLdev/${1:-${PWD:t}}.git"
}

# pkg / FreeBSD
alias pkgs='pkg search'
alias pkgi='doas pkg install'
alias pkgr='doas pkg remove'
alias pkgu='doas pkg update && doas pkg upgrade'
alias pkga='doas pkg autoremove'
alias pkgw='pkg which'
alias svc='doas service'
alias ports='cd /usr/ports'
# port multimedia/pipewire reinstall clean
port() { doas make -C "/usr/ports/$1" "${@:2}" }

# Hyprland
alias hr='hyprctl reload'
alias hc='nvim ~/.config/hypr/hyprland.lua'

# Apps
alias cl='claude'
alias clc='claude --continue'
alias clr='claude --resume'
alias ff='firefox &>/dev/null &!'   # zsh's &! backgrounds and disowns in one go

# nnn: cd into the directory you were in when you quit
n() {
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  command nnn "$@"
  [[ -f $NNN_TMPFILE ]] && { . "$NNN_TMPFILE"; rm -f "$NNN_TMPFILE" }
}

# Help: list aliases/functions with description and example. `help git` filters by section
_alias_help() {
  local -a entries=(
    "#Files & editors"
    "ls|List files with colors|ls ~/Repos"
    "ll|Long listing, including hidden files|ll ~/.config"
    "v|Open vim|v notes.txt"
    "nv|Open neovim|nv hyprland.lua"
    "n|nnn file manager; cd to last dir on quit|n ~/Repos"
    "#Navigation"
    "cd <dir>|cdpath: ~/.config, ~/Repos and ~ are searched|cd hypr"
    "~hypr|Jump to ~/.config/hypr (also ~nvim, ~kitty)|~kitty"
    "#Shell"
    "ze|Edit ~/.zshrc|ze"
    "zr|Reload ~/.zshrc|zr"
    "help|Show this help; optional section filter|help git"
    "#Git"
    "g|git|g stash"
    "gs|Short status with branch|gs"
    "ga|Stage files|ga hyprland.lua"
    "gaa|Stage everything|gaa"
    "gc|Commit with message|gc \"changed: blur radius\""
    "gcm|Commit as '<type>: <msg>'|gcm added pipewire autostart"
    "gacp|Add all, commit and push|gacp \"changed: colors to monochrome\""
    "gp|Push|gp"
    "gd|Diff unstaged changes|gd"
    "gds|Diff staged changes|gds"
    "gl|Last 15 commits as a graph|gl"
    "gb|List/manage branches|gb -M main"
    "gco|Checkout branch or file|gco hyprland.lua"
    "ginit|init repo, main branch, GFLdev SSH remote|ginit kitty"
    "#FreeBSD"
    "doas|Aliases expand after doas|doas nv /etc/rc.conf"
    "pkgs|Search packages|pkgs hyprpolkit"
    "pkgi|Install packages|pkgi grim slurp"
    "pkgr|Remove packages|pkgr ruby"
    "pkgu|Update repo catalog and upgrade all|pkgu"
    "pkga|Remove orphaned dependencies|pkga"
    "pkgw|Which package owns a file|pkgw /usr/local/bin/nvim"
    "svc|Manage services|svc dockerbox start"
    "ports|cd to the ports tree|ports"
    "port|make in a port directory|port multimedia/pipewire reinstall clean"
    "#Hyprland"
    "hypr|Start Hyprland in a ConsoleKit and D-Bus session|hypr"
    "hr|Reload Hyprland config|hr"
    "hc|Edit hyprland.lua|hc"
    "#Apps"
    "cl|Start Claude Code|cl"
    "clc|Continue last Claude session|clc"
    "clr|Pick a Claude session to resume|clr"
    "ff|Launch Firefox detached|ff"
  )
  local filter=${1:l} section="" show=1 e name desc ex
  for e in $entries; do
    if [[ $e == \#* ]]; then
      section=${e#\#}
      [[ -z $filter || ${section:l} == *$filter* ]] && show=1 || show=0
      (( show )) && print -P "\n%B%F{yellow}$section%f%b"
      continue
    fi
    (( show )) || continue
    name=${e%%|*}; e=${e#*|}; desc=${e%%|*}; ex=${e#*|}
    printf '  \e[1;36m%-9s\e[0m %-52s \e[2m$ %s\e[0m\n' "$name" "$desc" "$ex"
  done
  print
}
alias help='_alias_help'

# Prompt
eval "$(starship init zsh)"

# Delete key
bindkey "^[[3~" delete-char

# Variables
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export EDITOR="nvim"
export GOPRIVATE=github.com/
export TERM=st-256color

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

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv virtualenv-init -)"

# Hack: stop claude clode from freezing at 49 seconds
export BUN_JSC_useConcurrentGC=0
