source $HOME/.bashrc

source ~/.zplug/init.zsh

zplug "modules/editor",          from:prezto # emacs key bindings.
zplug "modules/directory",       from:prezto # automatic cd/pushd/popd etc.
zplug "modules/fasd",            from:prezto # cd to frequent/recent directories.
zplug "modules/history",         from:prezto # better command history.
zplug "modules/prompt",          from:prezto # prompt theme.

zstyle ':prezto:module:prompt' theme 'pure'

zplug load --verbose

source ~/.functions/fzf-git.sh

source /usr/local/opt/fzf/shell/completion.zsh   # use fzf for glob completion
source /usr/local/opt/fzf/shell/key-bindings.zsh # use fzf for history etc
