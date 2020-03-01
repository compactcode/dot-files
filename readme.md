## My configuration for terminal based software development.

### Requirements

* Elementary OS
* sudo apt-get install git

### Installation

```
git clone git://github.com/compactcode/dot-files.git && ./dot-files/install.sh
```

#### Post Install

* Import GPG Key

`gpg --import ./public_key`
`gpg --card-status`

* Create Postgres User

`sudo -u postgres createuser -s shandogs`

* Enable Postgres localhost Connections

https://gist.github.com/p1nox/4953113
