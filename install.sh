#!/bin/sh
#
# $Id: install.sh 2768 2007-06-17 09:09:29Z rafan $
#

cd

for i in profile/dot.*; do
	/bin/ln -fs ${i} ~/${i#profile/dot}
done
rm -f ~/.vim && /bin/ln -fs profile/vim ~/.vim

mkdir -p ~/.ssh
chmod 700 ~/.ssh
/bin/ln -fs ../profile/ssh/config ~/.ssh/config
