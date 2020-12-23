#!/usr/bin/env bash
set -e
set -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
CONFIG_SRC="$DIR/.config"
CONFIG_DEST="$HOME/.config"

# .config files
ln -sf "$CONFIG_SRC/alacritty" $CONFIG_DEST
mkdir -p "$CONFIG_DEST/ranger" && ln -sf "$CONFIG_SRC/ranger"/* $CONFIG_DEST/ranger/
mkdir -p "$CONFIG_DEST/i3" && ln -sf "$CONFIG_SRC/i3/config" $CONFIG_DEST/i3/
ln -sf "$CONFIG_SRC/compton.conf" $CONFIG_DEST
ln -sf "$CONFIG_SRC/zathura" $CONFIG_DEST
ln -sf "$CONFIG_SRC/Yubico" $CONFIG_DEST
ln -sf "$CONFIG_SRC/sxiv" $CONFIG_DEST
mkdir -p "$CONFIG_DEST/qutebrowser" && ln -sf "$CONFIG_SRC/qutebrowser"/*.py $CONFIG_DEST/qutebrowser/
ln -sf "$CONFIG_SRC/neofetch" $CONFIG_DEST
ln -sf "$CONFIG_SRC/lftp" $CONFIG_DEST
ln -sf "$CONFIG_SRC/aliasrc" $CONFIG_DEST
mkdir -p "$CONFIG_DEST/polybar" && ln -sf "$CONFIG_SRC/polybar"/* $CONFIG_DEST/polybar/

# extra stuff for pywal
mkdir -p "$CONFIG_DEST/wal" && ln -sf "$CONFIG_SRC/wal"/* $CONFIG_DEST/wal/
cp $CONFIG_SRC/wall.png $CONFIG_DEST
wal -R || wal -i $CONFIG_DEST/wall.png

# home files
ln -sf $DIR/.zshrc $HOME/
ln -sf $DIR/.profile $HOME/
ln -sf $DIR/.tmux.conf $HOME/
ln -sf $DIR/.powerline $HOME/
mkdir -p $DIR/.SpaceVim.d && ln -sf $DIR/.SpaceVim.d/* $HOME/.SpaceVim.d/
ln -sf $DIR/.xinitrc $HOME/
ln -sf $DIR/.gitconfig $HOME/

# .local/bin
mkdir -p "$HOME/.local/bin" && ln -sf $DIR/.local/bin/* $HOME/.local/bin/
