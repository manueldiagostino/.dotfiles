export ZDOTDIR=$HOME/.config/zsh

# --- XDG Base Directory Specification ---

# User-specific configuration files (default: ~/.config)
export XDG_CONFIG_HOME="$HOME/.config"

# User-specific data files (default: ~/.local/share)
export XDG_DATA_HOME="$HOME/.local/share"

# User-specific non-essential data files (default: ~/.cache)
export XDG_CACHE_HOME="$HOME/.cache"

# User-specific state data (default: ~/.local/state)
export XDG_STATE_HOME="$HOME/.local/state"

# # Ensure these directories exist to avoid errors in some applications
# mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME"
