#!/bin/sh
which yay || { echo "yay not found, please run install-yay.sh"; exit 1; }
yay -S --needed --noconfirm \
	qutebrowser \
	ranger \
	i3-gaps \
	compton-tryone-git \
	discord \
	slack-desktop \
	bitwarden \
	tmux \
	python-pip \
	python-pywal \
	mpv \
	youtube-dl \
	i3-gaps \
	polybar \
	alacritty \
	zsh \
	powerline \
	neovim \
	python-pynvim \
	zathura \
	zathura-pdf-poppler \
	sxiv \
	neofetch \
	lftp \
	feh \
	pandoc \
	wget \
	curl \
	htop \
	iotop \
	xorg-xwininfo \
	xorg-xdpyinfo \
  xorg-mkfontdir \
  xorg-mkfontscale \
  xclip \
	rofi \
  nerd-fonts-source-code-pro \
  nerd-fonts-terminus \
  ipython 


# spacevim
curl -sLf https://spacevim.org/install.sh | bash

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /bin/zsh
