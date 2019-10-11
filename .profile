#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export EDITOR='nvim'
export BROWSER="qutebrowser"
export READER="zathura"
export FILE="ranger"
export PAGER="less"
export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export KEYTIMEOUT=1
export TERM="xterm-256color"
export TERMINAL="alacritty"
export LD_LIBRARY_PATH="/usr/lib64/${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
export PATH="$PATH:/usr/local/cuda-10.0/bin/"
export QT_SCALE_FACTOR=1.75
export GPG_KEYID=0x245CB0E53BD78BFA
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

# Switch escape and caps if tty:
LOADKEYS="$HOME/.local/bin/ttymaps.kmap"
[ -f "$LOADKEYS" ] && sudo -n loadkeys "$LOADKEYS" 2>/dev/null

# Run pywal to apply color scheme
if [ $(command -v wal) ]; then
	wal -R >/dev/null 2>&1
fi

# Load resolution into env vars
[ -f "$HOME/.scripts/tools/getres" ] && source "$HOME/.scripts/tools/getres" >/dev/null

# Start GPG ssh
gpg-connect-agent updatestartuptty /bye
