export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="pure"

plugins=(
	zsh-autosuggestions zsh-syntax-highlighting
	archlinux
)

autoload -U promptinit; promptinit
prompt pure

export LANG=it_IT.UTF-8
export LC_ALL=it_IT.UTF-8


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# exa aliases
alias ls='exa'
alias ll='exa -lhgH --icons'
alias la='ll -a'
alias tree='exa -T --icons'

alias uni='cd ~/university'
alias tesi='cd ~/university/git/tesi'
alias open='xdg-open'
alias sshuni='ssh $(get_env unipr_usr)'
alias sshpc='ssh -XY $(get_env unipr_hpc)'
alias vpnuni='export U="$(get_env unipr_email)" ; export P="$(get_env unipr_psw)" ; sudo openfortivpn connect.unipr.it:4443 --username="$U" --password="$P"'

HPC_FOLDER='/home/manuel/university/23_24/hpc/'
alias r_send_hpc='rsync -avzP -e ssh "$HPC_FOLDER" "$(get_env unipr_hpc)":"$(get_env unipr_hpc_home)"'
alias r_recv_hpc='rsync -avzP -e ssh "$(get_env unipr_hpc)":"$(get_env unipr_hpc_home)" "$HPC_FOLDER"'

alias vim=nvim
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# docker
alias dkrm='export CONT_ALL=$(docker ps -aq) ; docker kill "$CONT_ALL" ; docker rm -f "$CONT_ALL"'

export PATH=~/.local/bin:/usr/local/texlive/2024/bin/x86_64-linux/:$PATH:/home/manuel/.cargo/bin

# zoxide
eval "$(zoxide init zsh)"
alias cd='z'

export JAVA_HOME='/usr/lib/jvm/java-11-openjdk'

# alias imv='imv -bFFFFFF'
alias tex2svg='function _tex2svg(){ filename="${1%.tex}"; pdflatex "$filename.tex" && pdf2svg "$filename.pdf" "$filename.svg"; }; _tex2svg'

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

export PATH=$PATH:/home/manuel/.local/lib/hyde
