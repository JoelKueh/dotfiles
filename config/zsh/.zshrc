
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fish style word skipping
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Ctrl + Left Arrow: Move cursor back one word
bindkey '^[[1;5D' backward-word      # ctrl + left arrow: cursor back one word
bindkey '^[OD'    backward-word      # second escape sequence for above
bindkey '^[[1;5C' forward-word       # ctrl + right arrow: cursor forward one word
bindkey '^[OC'    forward-word       # second escape sequence for above
bindkey '^H'      backward-kill-word # ctrl + h: delete previous word
bindkey '^[^?'    backward-kill-word # ctrl + backsapce: delete previous word
bindkey '^[[3;5~' kill-word          # ctrl + delete: delete subsequent word

# Set default editor
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi
alias vim="$EDITOR"
alias vi="$EDITOR"
alias v="$EDITOR"

