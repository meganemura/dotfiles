# # put below lines to '.bashrc'
# if [ -f ~/.bash_functions ]; then
#     . ~/.bash_functions
# fi
pecorake() {
    local rake="bundle exec rake"
    local task=$($rake --tasks | peco --prompt="task>" | cut -d " " -f 2)
    [ ! -z $task ] && $rake $task
  }
alias prake='pecorake'
