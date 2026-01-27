alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# exa aliases
alias ls='exa'
alias ll='exa -lhgH --icons'
alias la='exa -lahgH --icons'
alias tree='exa -T --icons'

export PATH=~/.local/bin:/usr/local/texlive/2025/bin/x86_64-linux/:$PATH

alias tex2svg='function _tex2svg(){ filename="${1%.tex}"; pdflatex "$filename.tex" && pdf2svg "$filename.pdf" "$filename.svg"; }; _tex2svg'

# Java
export JAVA_HOME='/usr/lib/jvm/java-21-openjdk/'
