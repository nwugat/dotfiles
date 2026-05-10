# Source defaults
[ -f /etc/bashrc ] && . /etc/bashrc

# Environment
user_path="$HOME/.local/bin:$HOME/bin:$HOME/scripts:$HOME/.cargo/bin"
if ! [[ "$PATH" =~ "$user_path" ]]; then
    PATH="$user_path:$PATH"
fi
export PATH
unset user_path

# Source modules in .bashrc.d
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Tools

EDITOR=nvim

command  v zoxide &1>/dev/null 2>&1 &&  eval "$(zoxide init bash)"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
