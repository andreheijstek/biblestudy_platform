alias migrate='rake db:migrate && rake db:migrate RAILS_ENV=test'
alias ..='cd ..' 
alias ...='cd ../..' 
alias ll='ls -GFHAf -1'
source ~/.git-completion.bash
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
source ~/.iterm2_shell_integration.`basename $SHELL`

# added by travis gem
[ -f /Users/andreheijstek/.travis/travis.sh ] && source /Users/andreheijstek/.travis/travis.sh

export EDITOR="rubymine"
export HEROKU_APP="biblestudy-platform"
eval "$(rbenv init -)"
