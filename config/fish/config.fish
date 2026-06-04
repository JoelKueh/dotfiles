if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR hx
set -gx VISUAL hx

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"
