# setup.sh does not create symlink of this file.
export PS1="\u@\h:\w\\$ "

export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/bin:$PATH"
export GOPATH=$HOME
export EDITOR=vim
export CLICOLOR=1

stty stop undef

# scala
export SCALA_HOME="/usr/local/Cellar/scala/2.11.2"
export PATH="$PATH:$SCALA_HOME/bin"

# python
export PYENV_ROOT=/usr/local/opt/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi


# Includes
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/hub.bash_completion.sh ]; then
    . /usr/local/etc/bash_completion.d/hub.bash_completion.sh
fi

if [ -f /usr/local/etc/bash_completion.d/go-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/go-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/scala ]; then
    . /usr/local/etc/bash_completion.d/scala
fi

if [ -f /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.bash ]; then
    . /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.bash
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

#export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.node/bin:$PATH"
export DISABLE_SPRING=1
