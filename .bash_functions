# vim: set ft=sh:
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
  git fetch --prune upstream && \
  git checkout master && \
  git merge --ff-only upstream/master && \
  git push origin master
}


follow_upstream_staging() {
  git fetch --prune upstream && \
  git checkout staging && \
  git merge --ff-only upstream/staging && \
  git push origin staging
}


_peco_checkout_branch() {
  branches=$(git for-each-ref --format="%(refname:short)" --sort=-committerdate refs/heads)
  branch=$(echo "$branches" | peco --prompt="Branch>")
  git checkout $branch

  git branch --verbose
}
alias co='_peco_checkout_branch'

_peco_checkout_branch_and_bundle_install() {
  _peco_checkout_branch
  echo
  echo '[bundle install]'
  echo
  bundle install
}
alias cob='_peco_checkout_branch_and_bundle_install'


_peco_change_directory_ghq() {
  dir=$(ghq list -p | peco --prompt="Repository>")
  test "$dir" && cd $dir
}
alias gd='_peco_change_directory_ghq'


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

function _edit_last_committed_files_by_vscode() {
  local files=$(_last_committed_files $@)
  test "$files" && code -p $files
}
alias elc='_edit_last_committed_files_by_vscode'

# Stage unstaged files using peco
function _peco_select_unstaged_files() {
  local base=$(git rev-parse --show-toplevel 2> /dev/null)
  local unstaged_files=$(git status --porcelain | grep -v "??" | peco | awk -F ' ' '{print $NF}')
  local files=$(for file in $unstaged_files; do echo $base/$file; done)
  test "$files" && git add $files
}
alias pdd='_peco_select_unstaged_files'

function _rename_current_branch() {
  local tmpfile=$(mktemp 2> /dev/null || mktemp -t tmp)
  trap "rm -f $tmpfile" EXIT

  local branch=$(git rev-parse --abbrev-ref HEAD)
  echo "$branch" > $tmpfile

  EDITOR="vim"
  $EDITOR $tmpfile
  git branch -m $branch $(cat $tmpfile)
}
alias rename_current_branch='_rename_current_branch'

alias mws='cd ~/src/github.com/meganemura/'
