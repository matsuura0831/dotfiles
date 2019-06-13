#!/bin/bash

CRNT_DIR=$(cd $(dirname $0); pwd)
PATH_CONFIG=${CRNT_DIR}/conf.d

DIR_CONFIG=$(cd $PATH_CONFIG && pwd)
DIR_BACKUP=backup

RC=~/.zshrc.local

echo "Install conf.d ------------------------------------------"
mkdir -p ${DIR_BACKUP}

for SRC_PATH in $(find ${DIR_CONFIG} -type f); do
  DST_PATH=$HOME${SRC_PATH#${DIR_CONFIG}}

  if [ -e ${DST_PTH} ]; then
    mv ${DST_PATH} ${DIR_BACKUP}/
  fi

  mkdir -p $(dirname $DST_PATH)
  ln -s ${SRC_PATH} ${DST_PATH}
done

echo "Install applications -------------------------------------"
sudo apt-get install -y vim-gnome xsel tmux
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

echo "Install ghq ---------------------------------------------"
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install -y golang-go

LINE=$(grep \$GOPATH $RC | wc -l)
if [ $LINE -eq 0 ]; then
  echo "export GOPATH=\$HOME/go" >> $RC
  echo "export PATH=\$GOPATH/bin:\$PATH" >> $RC
fi

if [ "$GOPATH" == "" ]; then
  . $RC
fi

go get github.com/peco/peco/cmd/peco
go get github.com/motemen/ghq
git config --global ghq.root ~/ghq

LINE=$(grep "alias g=" $RC | wc -l)
if [ $LINE -eq 0 ]; then
  echo "alias g='cd \$(ghq root)/\$(ghq list | peco)'" >> $RC
fi

