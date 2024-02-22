# Installation

For dotfiles:
```bash
cd ~
git clone git@github.com:manueldiagostino/.dotfiles.git # FIX: cambiare dopo release pubblica
cd .dotfiles
stow .
```

Theme and icons have to be set manually with `qt5ct`. 


## Dependencies

```bash
sudo pacman -S \
sddm openssh \
alacritty \
vi neovim \
cliphist \
dunst \
wofi \
jre-openjdk jdk-openjdk npm nodejs \
zathura zathura-pdf-poppler \
okular \
texlive biber texlive-lang \
kvantum qt5ct \
awk brightnessctl pamixer \
cmake hyprlang hyprpaper \
hypridle hyprlock \
slurp jq imv

# optional
yay -S \
wluma \
wayshot
```

## [SDDM](https://wiki.archlinux.org/title/SDDM)
Insert this lines into `/etc/sddm.conf.d/default.conf`:
```bash
[Theme]
	Current=catppuccin-macchiato
```

## [ssh-agent](https://wiki.archlinux.org/title/SSH_keys)
Once installed `openssh` you need to
```bash
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
```

The following is already given in `.zshrc`:
```bash
# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
```

## Awesome font
```bash
sudo pacman -S otf-font-awesome
```

## [Idle management](https://github.com/hyprwm/hypridle)
`# TODO:` 


## Lock screen
```bash
sudo pacman -S otf-font-awesome
```
