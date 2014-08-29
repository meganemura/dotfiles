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


follow_upstream() {
  git fetch --prune upstream
  git checkout master
  git merge --ff-only upstream/master
  git push origin master
}


_peco_checkout_branch() {
  branches=$(git for-each-ref --format="%(refname:short)" --sort=-committerdate refs/heads)
  branch=$(echo "$branches" | peco --prompt="Branch>")
  git checkout $branch

  git branch --verbose
}
alias co='_peco_checkout_branch'


# Edit last committed files
function _last_committed_files() {
  local ref=${@:-HEAD}
  local base=$(git rev-parse --show-toplevel 2> /dev/null)
  local last_committed_files=$(git diff-tree --no-commit-id --name-only -r $ref 2> /dev/null)
  for file in $last_committed_files; do
    echo $base/$file
  done
}
function _edit_last_committed_files() {
  local files=$(_last_committed_files $@)
  test "$files" && vim -p $files
}
alias el='_edit_last_committed_files'
