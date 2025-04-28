# Add user configurations here
# For HyDE not to touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.hyde.zshrc - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information

#  Aliases 
# Add aliases here

# open
alias open='xdg-open'

# exa aliases
alias ls='exa'
alias l='exa'
alias ll='exa -lhH --icons'
alias la='ll -a'
alias tree='exa -T --icons'

# nvim
alias vim=nvim

# zoxide
eval "$(zoxide init zsh)"
alias cd='z'

# git
alias guf='git_untracked list'
alias gufr='git_untracked remove'



#  This is your file 
# Add your configurations here

# Language
export LC_ALL=it_IT.UTF-8

# XDG stuff
export XDG_PICTURES_DIR="${HOME}/Immagini"

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


# latex
PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
PATH="${HOME}/.local/bin:$PATH"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/etc/profile.d/conda.sh" ]; then
#         . "/usr/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# HyDE command not found handler
unset -f command_not_found_handler
