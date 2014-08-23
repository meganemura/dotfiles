# # put below lines to '.bashrc'
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
alias ll='ls -1'

alias lv='lv -c'
alias bx='bundle exec'

# git shortcuts
alias di='git diff'
alias dc='git diff --cached'  # dc(1)
alias s='git status'
alias m='git branch --verbose'
alias show='git show'
alias gup='git add --update; git status --short --untracked-files=no'
alias rebase='git rebase -i master'
alias gd='cd $(ghq list -p | peco --prompt="Repository>")'


# typo fixes
alias gti='git'
alias gitt='git'
alias gits='git'

# fix for type <Space> before type 't'
# gi tst => git st
function gi () {
  git ${@##t}
}

alias uppercase="tr '[:lower:]' '[:upper:]'"
alias lowercase="tr '[:upper:]' '[:lower:]'"

# Edit last committed files
function el () {
  base=$(git rev-parse --show-toplevel 2> /dev/null)
  last_committed_files=$(git diff-tree --no-commit-id --name-only -r HEAD 2> /dev/null)
  files=$(for file in $last_committed_files; do echo $base/$file; done)
  test "$files" && vim -p $files
}
