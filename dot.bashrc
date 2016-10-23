#
# $Id: dot.bashrc 2948 2011-01-10 03:03:18Z rafan $
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:$HOME/bin; export PATH

OS=${OSTYPE/[^a-z]*/}
OSM=${OSTYPE/.[0-9]*/}

shopt -s histappend

export BLOCKSIZE=K;

export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim

if [ "${OS}" = "linux" ]; then
	export EDITOR=/usr/bin/vim
	export VISUAL=/usr/bin/vim
fi	

if [ "${OS}" = "cygwin" ]; then
	export EDITOR=/bin/vim
	export VISUAL=/bin/vim
fi	

export PAGER=/usr/bin/less

if [ "${OS}" = "cygwin" ]; then
	export PAGER=/bin/less
fi

if [ "${OS}" = "solaris" ]; then
	export PAGER=/usr/local/bin/less
fi

# make mail(1) happy:
crt=24;		export crt
MAILCHECK=600;	export MAILCHECK

export CLICOLOR_FORCE
export LANG=zh_TW.UTF-8
_ENG_LOCALE=en_US.UTF-8
if [ "$OSM" = "freebsd4" ]; then
	export LANG=zh_TW.Big5
	_ENG_LOCALE=en_US.ISO8859-1
elif [ "$OS" = "cygwin" ]; then
	export LANG=C
fi
export LC_MESSAGES=C
export LC_TIME=C
export LESS="-giMnrSw"
export LSCOLORS="Gxfxcxdxbxegedabagacad" # FreeBSD only
export LS_COLORS='di=1;36:ln=0;35:so=0;32:pi=0;33:ex=0;31:bd=0;34;46:cd=0;34;43' # Linux only
export HISTTIMEFORMAT="%F %T "

export FIGNORE=.svn:CVS

function color_prompt
{
	local CYAN='\[\e[36m\]'
	local B_RED='\[\e[1;31m\]'
	local B_YELLOW='\[\e[1;33m\]'
	local B_PURPLE='\[\e[1;35m\]'
	local B_CYAN='\[\e[1;36m\]'
	local NORMAL='\[\e[m\]'
	local SHTITLE='\[\ek\e\134\]'

	local JAILED=""
	if [ "${OS}" = "freebsd" ]; then
		if [ x"`/sbin/sysctl -n security.jail.jailed 2>/dev/null`" = "x1" ]; then
			JAILED="${B_RED}[J]${NORMAL}"
		fi;
	fi

	PS1="${NORMAL}${B_CYAN}\u@\h${NORMAL}${JAILED}|${LANG#zh_TW.} [${B_PURPLE}\w${NORMAL}] (${B_YELLOW}\A${NORMAL})"

	if [ ! -z "$WINDOW" ]; then
		PS1="${PS1} [${CYAN}W$WINDOW${NORMAL}]${SHTITLE}\$ "
	else
		PS1="${PS1}\$ "
	fi
	export PS1
}

color_prompt

# aliases
alias bye="/bin/sync; /bin/sync; clear;logout"
alias rm="/bin/rm -i"

# CMD Aliases
alias b5="env LANG=zh_TW.Big5 /usr/local/bin/luit"
alias cls="clear"
alias colorls="/bin/ls -FGw"
alias d="colorls"
alias dict="env LC_CTYPE=${_ENG_LOCALE} /usr/local/bin/dict"
alias finger="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/finger"
alias ftp="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/ftp"
alias g="grep"
alias grep="env LANG=${_ENG_LOCALE} /usr/bin/egrep --color=auto --mmap"
alias irssi="/usr/local/bin/irssi"
alias l="/usr/bin/last"
alias less="/usr/bin/less"
alias lftp="env LANG=${_ENG_LOCALE} lftp"
alias ll="ls -alrtF"
alias lock="/usr/bin/lock -n -p"
alias ls="colorls"
alias m="mutt"
alias mall="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/mail"
alias mutt="env LANG=en_US.UTF-8 /usr/local/bin/mutt -y"
alias n="/usr/bin/nslookup"
alias p="/sbin/ping"
alias psa="/bin/ps awx"
alias psr="psa -U root"
alias perldoc="LANG=C perldoc"
alias r="/usr/bin/fetch -q -o /dev/stdout 'http://www.random.org/cgi-bin/randnum?num=1&min=0&max=1&col=1'"
alias s="/usr/local/bin/screen"
alias ssh="/usr/bin/ssh -2 -4 -C"
alias sshfs="sshfs -o workaround=rename -o reconnect"
alias scp="/usr/bin/scp -2 -4 -C"
alias sort="env LANG=C /usr/bin/sort"
alias startx="exec startx"
alias t="telnet"
alias tar="env LANG=${_ENG_LOCALE} /usr/bin/tar"
alias telnet="/usr/bin/telnet -8"
alias talk="env LC_CTYPE=${_ENG_LOCALE} /usr/local/bin/ytalk"
alias top="/usr/bin/top -s1"
alias vncviewer="vncviewer -encodings 'copyrect tight hextile zlib corre rre' -compresslevel 9 -quality 9"
alias wall="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/wall"
alias write="env LC_CTYPE=${_ENG_LOCALE} /usr/bin/write"
alias zg="/usr/bin/zgrep --mmap"

# FreeBSD.org
alias dcvs="env CVS_RSH=ssh cvs -d rafan@dcvs.FreeBSD.org:/home/dcvs"
alias pcvs="env CVS_RSH=ssh cvs -d rafan@pcvs.FreeBSD.org:/home/pcvs"
alias projcvs="env CVS_RSH=ssh cvs -d rafan@projcvs.FreeBSD.org:/home/projcvs"
#alias scvs="env CVS_RSH=ssh cvs -d rafan@ncvs.FreeBSD.org:/home/ncvs"
export PSVN="svn+ssh://svn.freebsd.org/base"
alias ncvs="ssh -fNM ncvs.FreeBSD.org"
alias tb="ssh -fNM svm.bioinfo.tw"

if [ "${OS}" = "linux" -o "${OS}" = "cygwin" ]; then
	alias colorls="/bin/ls -F --show-control-chars --color=always"
	alias dict="/usr/bin/dict"
	alias grep="/bin/egrep --mmap"
	alias mutt="/usr/bin/mutt -y"
	alias s="/usr/bin/screen"
	alias tar="env LANG=${_ENG_LOCALE} /bin/tar"
	alias top="/usr/bin/top -d 1"
fi

if [ "${OS}" = "solaris" ]; then
	alias colorls="/usr/local/bin/gnuls -FG --show-control-chars --color=always"
	alias less="/usr/local/bin/less"
	alias top="/usr/local/bin/top -s1"
fi

function svnid() {
	svn ps svn:keywords Id "$@"
}

function svkid() {
	svk ps svn:keywords Id "$@"
}

function svndi() {
	svn di | perl -e '$p = $n = 0; while(<>) {if (/^-[^-]/) {$n++;} elsif (/^\+[^+]/) {$p++;}} printf("+%d -%d\n", $p,$n);'
}

function svkdi() {
	svk di | perl -e '$p = $n = 0; while(<>) {if (/^-[^-]/) {$n++;} elsif (/^\+[^+]/) {$p++;}} printf("+%d -%d\n", $p,$n);'
}

# ssh + screen title
function ss() {
	local last=${!#}
	# XXX alias does not work here
	printf '\033k\033\\$ %s:\n' "$last"
	#screen -t "$ |$last"":" /usr/bin/ssh -2 -4 -C "$@"
	ssh "$@"
}

# stuff that only needs when i login
if [ -t 0 -a -x /usr/local/bin/keychain ]; then

	# SSH Key
	if [ -f $HOME/.keychain/${HOSTNAME}-sh ]; then
		. $HOME/.keychain/${HOSTNAME}-sh
	fi

	if [ -f $HOME/.keychain/${HOSTNAME}-sh-gpg ]; then
		. $HOME/.keychain/${HOSTNAME}-sh-gpg
		export GPG_TTY=`tty`
	fi
fi

# shells/bash-completion
for i in /usr/local/etc /etc; do
	if [ -f ${i}/bash_completion ]; then
		. ${i}/bash_completion
	fi
done

# portupgrade
if [ -f /usr/local/share/examples/pkgtools/bash/complete.sample ]; then
	. /usr/local/share/examples/pkgtools/bash/complete.sample
fi

# portmaster
if [ -f /usr/local/share/portmaster/bash-completions ]; then
	. /usr/local/share/portmaster/bash-completions
fi

# local bashrc
if [ -r $HOME/.bashrc.local ]; then
	. $HOME/.bashrc.local
fi
