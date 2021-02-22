# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion" #agnoster

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

plugins=(
  git autojump osx gnu-utils
  zsh-syntax-highlighting zsh-completions
  fzf docker
)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
# User configuration

alias proxy='export https_proxy=http://127.0.0.1:1087; export http_proxy=http://127.0.0.1:1087'
alias unproxy='unset https_proxy; unset http_proxy'
alias no_proxy='export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.64.0/24'
#
#采用 GNU 方式的参数
alias ls='gls --color=auto'
alias dir='gdir --color=auto'
alias grep='grep --color=auto'
alias date='gdate'

alias chrome="open -a \"Google Chrome\" $@"
alias e="emacsclient"
alias em="emacs -nw"
alias vim="emacsclient"
alias aria2c="aria2c --conf-path='/Users/stream/.aria2.conf' -D"

# 关闭 C-s 的提醒
stty -ixon

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

alias clean-none-images="docker images | grep none | awk '{print $3}' | xargs docker rmi"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

loginName=`id -un`
# kafkaBinPath=/opt/kafka_2.11-0.10.1.0/bin/
# alias kafka-commands="docker exec -it kafka ls ${kafkaBinPath}"
# alias kafka-topics="docker exec -it kafka ${kafkaBinPath}kafka-topics.sh"
# alias kafka-configs='docker exec -it kafka ${kafkaBinPath}kafka-configs.sh'
# alias kafka-console-consumer='docker exec -it kafka ${kafkaBinPath}kafka-console-consumer.sh'
# alias kafka-consumer-groups='docker exec -it kafka ${kafkaBinPath}kafka-consumer-groups.sh'
# alias kafka-consumer-offset-checker='docker exec -it kafka ${kafkaBinPath}kafka-consumer-offset-checker.sh'
# alias kafka-streams-application-reset='docker exec -it kafka ${kafkaBinPath}kafka-streams-application-reset.sh'

# alias kafka-console-producer='docker exec -it kafka ${kafkaBinPath}kafka-console-producer.sh'
alias mysql-server-local-start="docker run --name mysql -v /Users/${loginName}/datas/mysql5.7/my.cnf:/etc/mysql/my.cnf -v /Users/${loginName}/datas/mysql5.7/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql:5.7.28"
alias mysql-server-local-stop="docker stop mysql && docker rm -v mysql"
alias mysql-server-local-restart="mysql-server-local-stop && mysql-server-local-start"

alias docker-registry-start="docker run -d -p 5000:5000 --name registry -v /Users/${loginName}/datas/docker-registry:/var/lib/registry registry:2"

alias mongo-cli='f() { docker run -it --rm --name mongo-cli-${RANDOM} mongo:3.6.15-xenial mongo --username ${1} --password ${2} --host ${3} }; f'

alias redis-start="docker run --name redis -p 6379:6379 -v /Users/${loginName}/datas/redis/redis.conf:/usr/local/etc/redis/redis.conf -v /Users/${loginName}/datas/redis/redis-data:/data -d redis:5.0.6"
alias redis-stop="docker stop redis && docker rm -v redis"
alias redis-restart="redis-stop-local && redis-start-local"
alias redis-cli='f() { docker run -it --rm --name redis-cli-${RANDOM} redis:5.0.6 redis-cli -h ${1} }; f'

alias plantuml-server-start="docker run -d --name plantuml -p 8080:8080 plantuml/plantuml-server:jetty"
alias plantuml-server-stop="docker stop plantuml && docker rm plantuml"

alias proxy-circe-rds="echo proxy rds of circe to local 4406 && ssh -Ng -L 4406:10.20.16.230:3306 -p 22 cnbroker"
alias proxy-maxwon-vip="echo proxy maxwon circe service to local 4407 && ssh -Ng -L 4407:10.20.16.199:3306 -p 22 cnbroker"
alias proxy-maxwon-default="echo proxy maxwon db of default to local 4408 && ssh -Ng -L 4408:10.20.15.198:3306 -p 22 cnbroker"
alias proxy-maxwon-general="echo proxy maxwon db of general to local 4409 && ssh -Ng -L 4409:10.20.15.189:3306 -p 22 cnbroker"

alias split="gsplit"
alias kc="kubectl"
alias local-ip="ipconfig getifaddr en0"

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

eval "$(jenv init -)"
