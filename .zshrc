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
ZSH=$HOME/.oh-my-zsh

# Alias function to attach tmux to remote session
function tssh() {
	ssh $1 -t tmux attach-session
}

function mkpdf() {
	lowriter --headless --convert-to pdf "$1" || exit 1
}

function cp-bulk() {
	rsync -axv --progress --files-from="$1" "$2" "$3"
}

# Apply pywal theme and powerline
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.powerline

# Helps to hide username at console prompt?
export DEFAULT_USER="$USER"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  git
  vi-mode
  zsh-syntax-highlighting
  zsh-autosuggestions
  history-substring-search
)


# ZSH config
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
ZSH_HIGHLIGHT_HILIGHTERS=(main brackets pattern cursor)


[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

neofetch
