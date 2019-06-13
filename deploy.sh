#!/bin/bash

CRNT_DIR=$(cd $(dirname $0); pwd)
PATH_CONFIG=${CRNT_DIR}/conf.d

DIR_CONFIG=$(cd $PATH_CONFIG && pwd)
DIR_BACKUP=backup

RC=~/.zshrc.local

IFS=$'\n'

echo "Install conf.d ------------------------------------------"
declare -A MAP
for i in $(ls -a ${DIR_CONFIG} | grep -v "^\.*$"); do
  MAP["$i"]=$HOME/$i
  echo $HOME/$i
done

mkdir -p ${DIR_BACKUP}

for i in ${!MAP[@]}; do
  echo "${i}"
  S=${DIR_CONFIG}/${i}
  SRC_DIR=$(cd $(dirname $S) && pwd)
  SRC_FILE=$(basename $S)
  SRC_PATH=${SRC_DIR}/${SRC_FILE}

  D=${MAP[$i]}
  DST_DIR=$(cd $(dirname $D) && pwd)
  DST_FILE=$(basename $D)
  DST_PATH=${DST_DIR}/${DST_FILE}

  echo "  deply: ${DST_PATH} -> ${DST_PATH}"

  if [ -f ${DST_PATH} ]; then
    mv ${DST_PATH} ${DIR_BACKUP}/${DST_FILE}
  fi
  rm -f ${DST_PATH}

  ln -s ${SRC_PATH} ${DST_PATH}
done

echo "Install applications -------------------------------------"
sudo apt-get install -y vim-gnome xsel tmux
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

echo "Install ghq ---------------------------------------------"
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt-get update
sudo apt-get install -y golang-go

LINE=$(grep \$GOPATH $RC | wc -l)
if [ $LINE -eq 0 ]; then
  echo "export GOPATH=\$HOME/go" >> $RC
  echo "export PATH=\$GOPATH/bin:\$PATH" >> $RC
fi

if ["$GOPATH" == ""]; then
  . $RC
fi

go get github.com/motemen/ghq
git config --global ghq.root ~/ghq

