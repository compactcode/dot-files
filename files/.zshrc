source $HOME/.bashrc

source ~/.zplug/init.zsh

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure,  from:github, use:pure.zsh, as:theme

zplug "modules/prompt", from:prezto

zstyle ':prezto:module:prompt' theme 'pure'

zplug load --verbose
