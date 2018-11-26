# vim: set ft=sh:
# # put below lines to '.bashrc'
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
alias l='ls -1'
alias ll='ls -1'
alias lll='ls -l'

alias lv='lv -c'
alias tree='tree --charset=C'
alias bx='bundle exec'

# git shortcuts
alias di='git diff'
alias dc='git diff --cached'  # dc(1)
alias s='git status'
alias m='git branch --verbose'
alias show='git show'
alias gup='git add --update :/; git status --short --untracked-files=no'
alias rebase='git rebase -i master'


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

alias jxa="osascript -l JavaScript"
alias reload-docker-env='eval $(docker-machine env)'
alias gg='cd ~/src/github.com/$USER'
alias update-gemfile-lock='git add Gemfile.lock; git commit -m"Update Gemfile.lock"'

which tailf || alias tailf="tail -f"

alias c=code
alias u="cd .."

alias cleanup-branches="git branch | grep pr- | xargs git br -D; git branch | grep -v master | grep -v staging | xargs git br -d"
alias vssh='vagrant ssh'
alias cl="ruby -e 'puts \"　\" * 10000'"

alias sha256sum="shasum -a 256"
alias git=hub

alias vs='vagrant ssh'

alias dp='docker-compose'
alias docomo='docker-compose'
alias dose='docker-compose'
alias c='code'
