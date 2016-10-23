#
# $Id: dot.bash_profile 2949 2012-03-07 13:51:04Z rafan $
#

# SSH key
if [ -t 0 -a -x /usr/local/bin/keychain -a -r $HOME/.ssh/key-def ]; then
	/usr/local/bin/keychain --nogui --agents ssh $HOME/.ssh/key-def
	/usr/local/bin/keychain --nogui --agents ssh $HOME/.ssh/key-217
fi

# local
if [ -r $HOME/.bash_profile.local ]; then
	. $HOME/.bash_profile.local
fi

. $HOME/.bashrc
