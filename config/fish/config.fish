if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"
<<<<<<< Updated upstream
=======
export _JAVA_AWT_WM_NONREPARENTING=1

# Colors
if test -x /usr/bin/dircolors
    if test -r ~/.dircolors
        eval (/usr/bin/dircolors -c ~/.dircolors | string replace 'setenv ' 'set -gx ')
    else
        eval (/usr/bin/dircolors -c | string replace 'setenv ' 'set -gx ')
    end

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
end

# History
set -g fish_history default
set -g fish_history_max 10000

# Prompt customization
function fish_prompt
    set -l user_host (set_color green)'['(whoami)'@'(prompt_hostname)']'(set_color normal)

    # Shorten directory components, retaining the final component.
    set -l cwd (prompt_pwd)

    # Git branch, if inside a Git repository.
    set -l git_info
    if command -q git
        set -l branch (command git branch --show-current 2>/dev/null)
        if test -n "$branch"
            set git_info (set_color yellow)" ($branch)"(set_color normal)
        end
    end

    # SSH indicator
    if set -q SSH_CLIENT; or set -q SSH_TTY; or set -q SSH_CONNECTION
        set user_host (set_color red)'[SSH] '(set_color normal)$user_host
    end

    echo -n $user_host$cwd$git_info' '
end

# Key bindings
# Ctrl + Left / Right: move by word
bind \e\[1\;5D backward-word
bind \eOD backward-word
bind \e\[1\;5C forward-word
bind \eOC forward-word

# Ctrl + H: delete previous word
bind \cH backward-kill-word

# Ctrl + Backspace: delete previous word
bind \e\x7f backward-kill-word

# Ctrl + Delete: delete next word
bind \e\[3\;5~ kill-word

# Ctrl + X: edit command line in external editor
bind \cx edit_command_buffer

# Set defaults
set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -gx MANROFFOPT '-c'

if command -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

alias vim='$EDITOR'
alias vi='$EDITOR'
alias v='$EDITOR'

# More aliases
alias ll='ls -l'
alias la='ls -lA'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

alias h='history | grep'
>>>>>>> Stashed changes
