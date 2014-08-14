# setup.sh does not create symlink of this file.

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export EDITOR=vim

stty stop undef

# Includes
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/go-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/go-completion.bash
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
