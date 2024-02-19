# Installation

For dotfiles:
```bash
cd ~
git clone git@github.com:manueldiagostino/.dotfiles.git
cd .dotfiles
stow .
```

Theme and icons have to be set manually with `qt5ct`. 


## Dependencies

```bash
sudo pacman -S \
vi neovim \
cliphist \
dunst \
wofi \
jre-openjdk jdk-openjdk npm nodejs \
zathura zathura-pdf-poppler \
okular \
texlive biber texlive-lang \
kvantum qt5ct
  
```
