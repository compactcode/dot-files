source $HOME/.bashrc

source ~/.zplug/init.zsh

# A fast, minimal prompt theme.
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure,  from:github, use:pure.zsh, as:theme

zplug load --verbose

# Enable Emacs key bindings.
bindkey -e
