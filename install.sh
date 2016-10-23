#!/bin/sh
#
# $Id: install.sh 2768 2007-06-17 09:09:29Z rafan $
#

cd

for i in profile/dot.*; do
	/bin/ln -fs ${i} ~/${i#profile/dot}
done
/bin/ln -fs profile/site-lisp ~/.site-lisp
/bin/ln -fs profile/vim ~/.vim
/bin/ln -fs profile/dot.Xdefaults .Xresources
