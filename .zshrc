#!/bin/zsh
#   file: .zshrc
#   Requires powerline, powerlevel9k, dmenu, zsh,
#   neofetch, loadkeys

# Start tmux on ssh
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# Exports
export KEYTIMEOUT=1
export TERM="xterm-256color"
export DOTDIR="$HOME/voidrice"

# Apply pywal theme and powerline
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.powerline
neofetch

# Helps to hide username at console prompt?
export DEFAULT_USER="$USER"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

ZSH_HIGHLIGHT_HILIGHTERS=(main brackets pattern cursor)

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions", defer:3
zplug 'bhilburn/powerlevel9k', as:theme, defer:2
zplug 'laurenkt/zsh-vimto'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
. "/etc/profile.d/conda.sh"
