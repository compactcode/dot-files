source $HOME/.bashrc

setopt AUTO_PUSHD        # Auto push old directory during cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.

source ~/.zplug/init.zsh

# A fast, minimal prompt theme.
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure,  from:github, use:pure.zsh, as:theme

zplug "modules/history", from:prezto # Save & share history between sessions.
zplug "modules/fasd",    from:prezto # Jump to recently used directories.

zplug load --verbose

# Enable Emacs key bindings.
bindkey -e
