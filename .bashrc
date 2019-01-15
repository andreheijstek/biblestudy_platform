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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export EDITOR="rubymine"
export EDITOR="/Applications/TextEdit.app/Contents/MacOS/TextEdit"
export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

eval "$(rbenv init -)"
