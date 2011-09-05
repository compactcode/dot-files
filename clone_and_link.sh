#!/bin/bash

cd &&
([ -d '.dot-files' ] || git clone git://github.com/compactcode/dot-files.git .dot-files) &&
([ -d '.oh-my-zsh' ] || git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh) &&
ls -1d .dot-files/files/* .dot-files/files/.* | while read f; do
  [ "$f" == '.dot-files/files/.' ] ||
  [ "$f" == '.dot-files/files/..' ] ||
  [ "$f" == '.dot-files/files/.git' ] ||
  ln -vsf "$f" .
done