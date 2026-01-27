#!/usr/bin/env zsh

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

# if ! source $ZDOTDIR/.zshenv; then
#     echo "FATAL Error: Could not source $ZDOTDIR/.zshenv"
#     return 1
# fi
