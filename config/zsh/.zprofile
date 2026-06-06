# Path configuration
export PATH=$HOME/opt/oss-cad-suite/bin:$PATH
export PATH=$HOME/opt/verible/bin:$PATH
export PATH=$HOME/.local/:$PATH
export PATH=$PATH:$HOME/.cargo/bin

# Other environment variable configuration
if [[ -e '/opt/riscv' ]]; export RISCV=/opt/riscv; fi
export _JAVA_AWT_WM_NONREPARENTING=1
