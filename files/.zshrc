source $HOME/.bashrc

source ~/.zplug/init.zsh

# A fast, minimal prompt theme.
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure,  from:github, use:pure.zsh, as:theme

zplug "modules/history", from:prezto # Save & share history between sessions.
zplug "modules/fasd",    from:prezto # Jump to recently used directories.

zplug load --verbose

# Enable Emacs key bindings.
bindkey -e
