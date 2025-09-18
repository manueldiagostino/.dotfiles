#----------------------------#

plugins=(git archlinux)

alias open='xdg-open'
alias vim=nvim

# zoxide
eval "$(zoxide init zsh)"
alias cd='z'

# git
alias guf='git_untracked list'
alias gufr='git_untracked remove'

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [[ "$ZSH_CONDA" == "1" ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
fi

# TeX Live 2025
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:${MANPATH:-}"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:${INFOPATH:-}"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

eval "$(direnv hook zsh)"
