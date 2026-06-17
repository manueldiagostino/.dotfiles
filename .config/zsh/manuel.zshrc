source ~/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

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
	[ -f ~/miniconda3/bin/activate ] && source ~/miniconda3/bin/activate
	export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
fi

# TeX Live 2025
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:${MANPATH:-}"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:${INFOPATH:-}"
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export PATH="/home/manuel/.local/bin:$PATH"
export PATH="/home/manuel/.local/share/nvim/mason/bin:$PATH"
export PATH="/home/manuel/.cargo/bin:$PATH"
export PATH="/home/manuel/.npm-global/bin:$PATH"

eval "$(direnv hook zsh)"

# Java
export JAVA_HOME='/usr/lib/jvm/java-21-openjdk/'

export EDITOR=nvim

# alias opencode="CHUTES_API_KEY=\$(pass chutes/api_key) opencode"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

omos() {
  local port
  port=$(jot -r 1 49152 65535)
  OPENCODE_PORT="$port" \
  opencode --port "$port" "$@"
}

# >>> oh-my-opencode-slim background subagents >>>
export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true
# <<< oh-my-opencode-slim background subagents <<<
