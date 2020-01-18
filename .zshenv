#!/usr/bin/env zsh

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/stream/bin:/usr/local/opt/coreutils/libexec/gnubin"
GNU_BIN=/usr/local/opt/coreutils/libexec/gnubin

export PYTHON_PATH=/usr/local/opt/python/libexec/bin

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=/Users/stream/codes/golang

export PATH=$PYTHON_PATH:$PATH:$GNU_BIN:$GOROOT/bin:$GOPATH/bin
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#jenv
export PATH="$HOME/.jenv/bin:$PATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export TERM=xterm-256color
export GO111MODULE=auto
export GOPROXY=https://goproxy.io
