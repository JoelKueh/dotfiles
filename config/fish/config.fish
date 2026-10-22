if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

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
    if set -q SSH_CLIENT; or set -q SSH_TTY; or set -q SSH_CONNECTION
        set_color red
        printf '[SSH] '
    end

    set_color green
    printf '[%s@%s]' (whoami) (prompt_hostname)

    set_color normal
    printf '%s' (prompt_pwd)

    set_color yellow
    fish_vcs_prompt

    set_color normal
    printf '%% '
end

# Key bindings
# Ctrl + Left / Right: move by word
bind \e\[1\;5D backward-word
bind \eOD backward-word
bind \e\[1\;5C forward-word
bind \eOC forward-word

bind \cH backward-kill-word    # Ctrl + H: delete previous word
bind \e\x7f backward-kill-word # Ctrl + Backspace: delete previous word
bind \e\[3\;5~ kill-word       # Ctrl + Delete: delete next word
bind \cx edit_command_buffer   # Ctrl + X: edit command line in external editor

# Set defaults
set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -gx MANROFFOPT '-c'

if command -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

# SVUnit and UVM
set -gx SVUNIT_INSTALL "$HOME/opt/svunit-master"
fish_add_path --path "$SVUNIT_INSTALL/bin"
set -gx UVM_HOME "$HOME/opt/uvm-verilator"

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

set -g fish_greeting
