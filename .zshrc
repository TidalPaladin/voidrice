#!/bin/zsh
#   file: .zshrc
#   Requires powerline, powerlevel9k, dmenu, zsh,
#   neofetch, loadkeys

# Start tmux on ssh
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi



# Exports
export EDITOR="vim"
export KEYTIMEOUT=1
export TERM="xterm-256color"
export DOTDIR="$HOME/voidrice"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

# Apply pywal theme and powerline
WAL_DIR="$HOME/.cache/wal"
[ -f "$WAL_DIR/sequences" ] && (cat "$WAL_DIR/sequences" &)
[ -f "$WAL_DIR/colors-tty.sh" ] && source "$WAL_DIR/colors-tty.sh"
[ -f "$HOME/.powerline" ] && source "$HOME/.powerline"

neofetch

# Helps to hide username at console prompt?
export DEFAULT_USER="$USER"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

ZSH_HIGHLIGHT_HILIGHTERS=(main brackets pattern cursor)

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" > /dev/null 2>&1
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc" > /dev/null 2>&1

if [ -f "$HOME/.zplug/init.zsh" ]; then
	source ~/.zplug/init.zsh
	zplug "zsh-users/zsh-autosuggestions", defer:3
	zplug 'bhilburn/powerlevel9k', as:theme, defer:2
	zplug 'laurenkt/zsh-vimto'
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Anaconda
if [ -f "$HOME/anaconda3/bin/conda" ]; then
  conda &>/dev/null || export PATH="$PATH:$HOME/anaconda3/bin"
  . /home/tidal/anaconda3/etc/profile.d/conda.sh
fi

[ $(command -v gpg-connect-agent) ] && gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
