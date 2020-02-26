export EDITOR=nvim

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '\.git'"
export FZF_DEFAULT_OPTS="--reverse --height 40%"

# Ruby
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

# Git
alias g='git'
alias ga='git add'
alias gars='git add . && git reset --hard'
alias gc='git commit -v'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias glg='git log --stat'
alias glr='git pull --rebase'
alias gp='git push'
alias grh='git reset HEAD'
alias grs='git reset --hard'
alias gs='git status'

# Vim
alias v='nvim'

# Utility
alias l='exa -la'
alias md='mkdir -p'

# Add homebrew utilities to the path.
export PATH="/home/linuxbrew/.linuxbrew/bin/:$PATH"

# Ruby version management.
source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh
source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/auto.sh

# GPG Prompt.
export "GPG_TTY=$(tty)"

# Replace SSH with GPG.
export "SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)"
