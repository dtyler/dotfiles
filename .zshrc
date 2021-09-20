# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export SHELL=`which zsh`

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh" # nebirhos, superjarin

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
_gt_goto_project() {
  cd $1
  if [[ -f env.sh ]]; then
    source env.sh
  fi
}
gt() {
  if [[ $# == 1 ]]; then
    find ~/projects -maxdepth 3 -type d -iname "$(echo $@ | tr -s ' ' '*')*" | while read line; do
      if [[ $(basename $line) == $1 ]]; then
        _gt_goto_project $line
        return 0
      fi
    done
  fi
  TARGET=`find ~/projects -maxdepth 3 -type d -iname "$(echo $@ | tr -s ' ' '*')*" | head -n 1`
  if [[ -n $TARGET ]]; then
    _gt_goto_project $TARGET
  fi
}
function _gt_completion() {
  local prefix=$1
  reply=($(find ~/projects -maxdepth 3 -type d -iname "$(echo $prefix | tr -s ' ' '*')*" -exec basename {} \;))
}
compctl -K _gt_completion gt
function gvim { /usr/local/bin/gvim }
function sshck { ps aux | grep 'ssh ' | grep -v grep }
function llocate { find . -maxdepth 3 -name $1 }

# Nova alias
alias nova_prod=''
alias nova_dr=''
alias nova_stage=''
alias nova_qa=''
alias nova_pass='echo "Enter AD password for nova"; read -rs OS_PASSWORD ; export OS_PASSWORD'
alias nova_env='echo $OS_AUTH_URL'
function nova_tenant { export OS_PROJECT_NAME="$1" }
function nn {
  for search_tenant in $(echo ${2:-$OS_PROJECT_NAME} | tr ',' ' ')
  do
    OS_PROJECT_NAME=$search_tenant openstack server list --name "$1"
  done
}
alias shared_gotty="gotty -c roving:roving -w --max-connection 2 tmux new -A -s shared"

# Nova Default setup
OS_USERNAME=`whoami`
export OS_USERNAME
OS_PROJECT_NAME='admin'
export OS_PROJECT_NAME
OS_AUTH_URL=''
export OS_AUTH_URL

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Makes cd=pushd
setopt AUTO_PUSHD

# pushd with no args goes HOME
setopt PUSHD_TO_HOME

# don't verify history substitutions
setopt no_hist_verify

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew colored-man-pages colorize gem git httpie jira jsontools mvn npm sudo rbenv tmux vagrant vi-mode  zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh
bindkey '≥' insert-last-word
bindkey '^r' history-incremental-search-backward

# Export GOPATH
export GOPATH=/Users/dtyler/projects/go

# Customize to your needs...
PATH=/sbin:/usr/local/sbin:/usr/local/bin:/usr/local/opt/mysql@5.5/bin:$PATH
PATH="$GOPATH/bin:$PATH" # add GOPATH to PATH
PATH="/Users/dtyler/.cargo/bin:$PATH" # Rust's cargo installed binaries
PATH=~/Library/Python/2.7/bin:$PATH
export MANPATH=~/Library/Python/2.7/share/man:$MANPATH
export PATH="$PATH:./node_modules/.bin:/usr/local/groovy-2.0.8/bin:/Users/dtyler/bin:/sbin:/Applications/VMware Fusion.app/Contents/Library"

# Other vars
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath "$JAVA_HOME"
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH="$JAVA_HOME/bin:$PATH"
  fi
}
function removeFromPath() {
 export PATH="$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")"
}
setjdk 1.8

function findConfiguredMaster() {
  ssh -q p2-team-jenkins-slave-$1.ctct.net -C "cat /etc/facter/facts.d/_orchestra_facts.yaml | grep jenkins_hostname"
}

function sane_displays {
  displayplacer "id:0828B3F6-3CF3-D024-9DBA-4FDA1A23E255 res:1920x1080 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:A7CE4FC6-6367-835D-9397-89E3EE3CA02A res:1680x1050 color_depth:4 scaling:on origin:(0,1080) degree:0" "id:FE439449-546E-2E4A-8432-25EF54DA1741 res:1080x1920 hz:60 color_depth:8 scaling:off origin:(-1080,-241) degree:90" 
}

export GROOVY_HOME=/usr/local/groovy-2.0.8/
export CC_ENV=d1

export JIRA_URL="https://jira.endurance.com"
export JIRA_RAPID_BOARD=true # used by jira cli

alias sshc='ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias ssh='TERM=xterm-256color ssh'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export LESS="-F -X $LESS"

# NVM
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# AWSume 
alias awsume=". awsume"
