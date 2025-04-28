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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
