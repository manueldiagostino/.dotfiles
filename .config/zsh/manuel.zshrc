# # Helpful aliases
alias c='clear'                                                        # clear terminal
alias l='eza -lh --icons=auto'                                         # long list
alias ls='eza -1 --icons=auto'                                         # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto'                                       # long list dirs
alias lt='eza --icons=auto --tree'                                     # list folder as tree

# # Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager

#----------------------------#

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
fi

# TeX Live 2025
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:${MANPATH:-}"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:${INFOPATH:-}"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

eval "$(direnv hook zsh)"

# Java
export JAVA_HOME='/usr/lib/jvm/java-21-openjdk/'
