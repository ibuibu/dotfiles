#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
bindkey -v

# タイムアウト時間を0.01秒に
#KEYTIMEOUT=1

## alias
alias relogin='exec $SHELL -l'
alias c='code .'
alias de='cd ~/Desktop'
alias ls='exa --icons'
alias l='exa --icons -1'
alias la='exa -la'
alias v='nvim'
alias vzsh='nvim ~/.zshrc'
alias vinit='nvim ~/.config/nvim/init.vim'
alias vdein='nvim ~/.config/nvim/dein.toml'

## for skyway hcloud shortcut
function hc() {
  if [ $# -le 1 -o $# -ge 5 ]; then
    echo "引数は2〜5つにしてYO"
    return
  fi

  case $1 in
    g) cloud="gcp" ;;
    e) cloud="ecl" ;;
    *) echo "Bad cloud name!!" ;;
  esac
  case $2 in
    s) environment="staging" ;;
    p) environment="production" ;;
    *) echo "Bad environment name!!" ;;
  esac
  
  cache=''
  if [ $(echo ${@:$#:1} = 'c') ]; then
    cache='--cache'
  fi

  if [ $# = 2 ]; then
    hcloud members ${cloud} ${environment} -m in_service is_available is_obsoleted ${cache}
  fi

  if [ $# -ge 3 ]; then
    hcloud members ${cloud} ${environment} -g $3 -m in_service is_available is_obsoleted ${cache}
  fi
}


# ghq alias
alias g='cd $(ghq root)/github.com/$(ghq list | cut -d "/" -f 2,3 | sort | fzf)'
alias gr='gh repo view -w $(ghq list | fzf | cut -d "/" -f 2,3)'

# ssh-add
ssh-add ~/.ssh/key/skyway_sv/new/id_rsa

# 環境変数
export VISUAL='nvim'
export EDITOR='nvim'

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# cdしたら自動でls
function chpwd() { ls -Fa }

# '^' を押すと上のディレクトリに移動する
# function cdup() {
# echo
# cd ..
# zle reset-prompt
# }
# zle -N cdup
# bindkey '\^' cdup

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups

# mkdirとcdを同時実行
alias mkdir='(){mkdir $1;cd $1}'

#fzfを使ってすぐにssh
function hssh {
  if [ $# = 3 ]; then
    HOSTNAME="$(hcloud members --cache $1 $2 -g $3 -m in_service is_available| grep -v 'name\|------' | fzf | awk '{print $1}')"
  elif [ $# = 2 ]; then
    HOSTNAME="$(hcloud members --cache $1 $2 -m in_service is_available | grep -v 'name\|------' | fzf | awk '{print $1}')"
  else
    echo "引数は2つか3つにしてYO!!"
    return
  fi
  ssh -A $HOSTNAME
}

#PATH
export PATH=$PATH:/Users/hirokiibuka/depot_tools
export PATH=$PATH:/Users/hirokiibuka/.command

# go
export GOROOT=/usr/local/Cellar/go/1.15.7/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# gh-cli
eval "$(gh completion -s zsh)"

# githubにリポジトリを作り、ghqで取得、vscodeでひらく
function ghcr() {
  gh repo create $argv
  ghq get $argv[1]
  code $(ghq list --full-path -e $argv[1])
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hirokiibuka/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hirokiibuka/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hirokiibuka/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hirokiibuka/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# anyenv
eval "$(anyenv init -)"

RPROMPT="%F{8} %D{%m/%d %H:%M:%S} %f"
