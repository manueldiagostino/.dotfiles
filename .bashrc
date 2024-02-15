#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# exa aliases
alias ls='exa'
alias ll='exa -lhgH --icons'
alias la='exa -lahgH --icons'
alias tree='exa -T --icons'

# dot-net
# export DOTNET_ROOT=$(pwd)/.dotnet
# export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=$PATH:~/.dotnet/tools
