
# Colors
autoload -U colors && colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Autocompletion
autoload -Uz compinit
if [ "$(find $ZDOTDIR/.zcompdump -mtime +1 2>/dev/null)" ]; then compinint; fi
compinit -C

# Autosuggestions
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Prompt customization
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git
setopt PROMPT_SUBST
zsh_prompt_short_path() { print -P '%~' | sed -E 's|([^/])[^/]*/|\1/|g' }
PROMPT='%F{green}[%n@%m]%f$(zsh_prompt_short_path)%F{yellow}${vcs_info_msg_0_}%f%# '
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
    PROMPT="%F{red}[SSH] $PROMPT"
fi
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

# Keybinds
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X' edit-command-line

# Set Defaults
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"
# Set default editor
export EDITOR='gvim -v'
alias vim="$EDITOR"
alias vi="$EDITOR"
alias v="$EDITOR"

# More Aliases
alias ll="ls -l"
alias la="ls -la"

# Source environment for VLSI Design
ss() {
    export OA_UNSUPPORTED_PLAT=linux_rhel70_gcc93x
    source /project/F26-EE5323/Setup/env.sh
}

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

alias ll="ls -l"
alias la="ls -lA"
alias h="history | grep"

[[ -f ~/EE5327.zshrc ]] && source ~/EE5327.zshrc

export PATH="$HOME/opt/verible/verible/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Qwen Code PATH block begin
export PATH="$HOME/.local/bin:$PATH"
# Qwen Code PATH block end

