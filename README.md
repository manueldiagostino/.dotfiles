# Installazione

```bash
cd ~
git clone git@github.com:manueldiagostino/.dotfiles.git
cd .dotfiles
stow .
```

## Dipendenze

```bash
sudo pacman -S \
  vi neovim \
  cliphist \ # clipboard manager
  dunst \ # notification deamon
  wofi \ # app launcher
  java npm nodejs \
  zathura zathura-pdf-poppler \ # vimtex pdf viewer
  okular \ # pdf reader
  texlive biber texlive-lang \ # LaTeX stuff
  
```
