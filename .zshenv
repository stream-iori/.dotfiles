#!/usr/bin/env zsh

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sajia/bin:/usr/local/opt/coreutils/libexec/gnubin"
GNU_BIN=/usr/local/opt/coreutils/libexec/gnubin

export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec

export PATH=$PYTHON_PATH:$PATH:$GNU_BIN:$GOROOT/bin:$GOPATH/bin
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export DOTFILES=$HOME/.dotfiles
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#jenv
export PATH="$HOME/.jenv/bin:$PATH"
#node12
export PATH="/usr/local/opt/node@12/bin:$PATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export TERM=xterm-256color
export GO111MODULE=auto
export GOPROXY=https://goproxy.cn,direct
. "$HOME/.cargo/env"
