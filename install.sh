#!/bin/sh
#
# $Id: install.sh 2768 2007-06-17 09:09:29Z rafan $
#

set -o errexit

# Get base directory, relative to $HOME
basedir=$(dirname $0)
basedir=$(cd $basedir; pwd)
basedir=${basedir#$HOME/}

cd ~

for i in $basedir/dot.*; do
	/bin/ln -fs ${i} ~/${i#$basedir/dot}
done
rm -f ~/.vim && /bin/ln -fs $basedir/vim ~/.vim

mkdir -p ~/.ssh
chmod 700 ~/.ssh
/bin/ln -fs ../$basedir/ssh/config ~/.ssh/config
