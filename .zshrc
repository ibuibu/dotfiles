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

alias relogin='exec $SHELL -l'
alias c='code .'
alias ls='exa --icons'
alias l='exa --icons -1'

# ghq alias
alias g='cd $(ghq root)/github.com/$(ghq list | cut -d "/" -f 2,3 | sort | fzf)'
alias gr='gh repo view -w $(ghq list | fzf | cut -d "/" -f 2,3)'

# ssh-add
ssh-add ~/.ssh/key/skyway_sv/new/id_rsa

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# cdしたら自動でls
function chpwd() { ls -Fa }

# '^' を押すと上のディレクトリに移動する
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups

# mkdirとcdを同時実行
alias mkdir='(){mkdir $1;cd $1}'

#fzfを使ってすぐにssh
function hssh {
  if [ $# = 3 ]; then
    HOSTNAME="$(hcloud members --cache $1 $2 -g $3 | grep -v 'name\|------' | fzf | awk '{print $1}')"
  elif [ $# = 2 ]; then
    HOSTNAME="$(hcloud members --cache $1 $2 | fzf | awk '{print $1}')"
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
