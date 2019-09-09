# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster" #agnoster

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git emacs ruby lighthouse)
plugins=(git tig autojump osx kubectl gnu-utils zsh-completions)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/Users/stream/bin:/usr/local/opt/coreutils/libexec/gnubin"
GNU_BIN=/usr/local/opt/coreutils/libexec/gnubin

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=/Users/stream/codes/golang

export PATH=$PATH:$GNU_BIN:$GOROOT/bin:$GOPATH/bin:$BTRACE/bin
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export editor=nvim
. /Users/stream/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh

alias proxy='export all_proxy=http://127.0.0.1:1087'
alias unproxy='unset all_proxy'
#
#采用 GNU 方式的参数
alias ls='gls --color=auto'
alias dir='gdir --color=auto'
alias grep='grep --color=auto'
alias date='gdate'

alias chrome="open -a \"Google Chrome\" $@"
alias vim="nvim"
# 关闭 C-s 的提醒
stty -ixon
# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export TERM=xterm-256color

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
#
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null;
  then eval "$(pyenv init -)";
  fi
export LC_ALL=en_US.UTF-8

alias clean-none-images="docker images | grep none | awk '{print $3}' | xargs docker rmi"


# kafkaBinPath=/opt/kafka_2.11-0.10.1.0/bin/
# alias kafka-commands="docker exec -it kafka ls ${kafkaBinPath}"
# alias kafka-topics="docker exec -it kafka ${kafkaBinPath}kafka-topics.sh"
# alias kafka-configs='docker exec -it kafka ${kafkaBinPath}kafka-configs.sh'
# alias kafka-console-consumer='docker exec -it kafka ${kafkaBinPath}kafka-console-consumer.sh'
# alias kafka-consumer-groups='docker exec -it kafka ${kafkaBinPath}kafka-consumer-groups.sh'
# alias kafka-consumer-offset-checker='docker exec -it kafka ${kafkaBinPath}kafka-consumer-offset-checker.sh'
# alias kafka-streams-application-reset='docker exec -it kafka ${kafkaBinPath}kafka-streams-application-reset.sh'

# alias kafka-console-producer='docker exec -it kafka ${kafkaBinPath}kafka-console-producer.sh'

alias redis-start-local="docker run --name redis -p 6379:6379 -d redis:5.0.5"
alias redis-stop-local="docker stop redis && docker rm -v redis"
alias redis-cli-local="docker exec -it redis redis-cli "

alias proxy-circe-rds="echo proxy rds of circe to local 4406 && ssh -Ng -L 4406:10.20.16.230:3306 -p 22 cnbroker"
alias proxy-maxwon-vip="echo proxy maxwon circe service to local 4407 && ssh -Ng -L 4407:10.20.16.199:3306 -p 22 cnbroker"
alias proxy-maxwon-default="echo proxy maxwon db of default to local 4408 && ssh -Ng -L 4408:10.20.15.198:3306 -p 22 cnbroker"
alias proxy-maxwon-general="echo proxy maxwon db of general to local 4409 && ssh -Ng -L 4409:10.20.15.189:3306 -p 22 cnbroker"

alias split="gsplit"
alias kc="kubectl"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

function prev_record() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
KUBECTX_IGNORE_FZF=1
KUBE_PS1_SYMBOL_USE_IMG=true

#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc
