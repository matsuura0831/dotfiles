#!/bin/bash

if [ $# -ne 1 ]; then
  PATH_CONFIG=./conf
else
  PATH_CONFIG=$1
fi

DIR_CONFIG=$(cd $PATH_CONFIG && pwd)
DIR_BACKUP=backup
FILE_TSV=map.tsv

declare -A MAP

IFS=$'\n'

for i in $(ls -a ${DIR_CONFIG} | grep -v "^\.*$"); do
  MAP["$i"]=$HOME/$i
  echo $HOME/$i
done

if [ -f ${FILE_TSV} ]; then
  for i in $(cat ${FILE_TSV}); do
    KEY=$(echo $i | cut -f 1)
    VAL=$(echo $i | cut -f 2)
    if [ "" != "$KEY" -a "" != "$VAL" ]; then
      MAP["$KEY"]=$(echo $VAL)
    fi
  done
fi

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

sudo apt-get install -y vim-gnome xsel tmux
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
