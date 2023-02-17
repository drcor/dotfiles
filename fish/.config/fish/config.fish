#! /bin/sh

set fish_greeting   # Remove default fish startup message

export EDITOR=nvim || export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GPG_TTY=$(tty)

# Import configuration files
source $HOME/.config/fish/shortcuts.fish
source $HOME/.config/fish/colors.fish

alias la='exa -lha' # List directories with color
alias df='df -h'
alias du='du -ch'
alias emacs='emacs -nw'

# Initialize starship
starship init fish | source

# Print startup message
echo -e "\n"
neofetch
