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

export PATH=~/.local/bin:/usr/local/texlive/2023/bin/x86_64-linux/:$PATH

export QT_QUICK_CONTROLS_STYLE=org.kde.desktop

alias tex2svg='function _tex2svg(){ filename="${1%.tex}"; pdflatex "$filename.tex" && pdf2svg "$filename.pdf" "$filename.svg"; }; _tex2svg'
