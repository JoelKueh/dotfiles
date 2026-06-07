
# Autocompletion and autosuggestions
autoload -Uz compinit && compinit
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt customization
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git
setopt PROMPT_SUBST
zsh_prompt_short_path() { print -P '%~' | sed -E 's|([^/])[^/]*/|\1/|g' }
PROMPT='[%n@%m]$(zsh_prompt_short_path)${vcs_info_msg_0_}%# '

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

alias ll="ls -l"
alias la="ls -la"

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias ll="ls -l"
alias la="ls -la"
alias h="history | grep"
