#!/bin/sh

set -o errexit

# Get base directory, relative to $HOME
basedir=$(dirname $0)
basedir=$(cd $basedir; pwd)
basedir=${basedir#$HOME/}

cd ~
cd $basedir

git submodule update --remote

# init with public dotfiles
./dotfiles/install.sh

# install customization
cd ~

for i in $basedir/dot.*; do
	/bin/ln -fs ${i} ~/${i#$basedir/dot}
done

/bin/ln -fs ../$basedir/ssh/config.local ~/.ssh/config.local
