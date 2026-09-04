# Path configuration
export PATH=$HOME/opt/oss-cad-suite/bin:$PATH
export PATH=$HOME/opt/verible/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.cargo/bin

# Other environment variable configuration
[[ -e '/opt/riscv' ]] && export RISCV=/opt/riscv
export _JAVA_AWT_WM_NONREPARENTING=1
