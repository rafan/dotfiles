#
# $Id: dot.bashrc 2948 2011-01-10 03:03:18Z rafan $
#

umask 0077

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:$HOME/bin; export PATH

OS=${OSTYPE/[^a-z]*/}

shopt -s histappend

export BLOCKSIZE=K;

export EDITOR=vim
export VISUAL=vim
export PAGER=less

# make mail(1) happy:
crt=24;		export crt
MAILCHECK=600;	export MAILCHECK

export CLICOLOR_FORCE
export LANG=zh_TW.UTF-8
_ENG_LOCALE=en_US.UTF-8
export LC_MESSAGES=C
export LC_TIME=C
export LESS="-giMnrSw"
export LSCOLORS="Gxfxcxdxbxegedabagacad" # FreeBSD only
export LS_COLORS='di=1;36:ln=0;35:so=0;32:pi=0;33:ex=0;31:bd=0;34;46:cd=0;34;43' # Linux only
export HISTTIMEFORMAT="%F %T "

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

    if [ -f ~/.git-prompt.sh ]; then
        . ~/.git-prompt.sh
        GIT_PROMPT='$(__git_ps1 "(%s)")'
    fi

	PS1="${NORMAL}${B_CYAN}\u@\h${NORMAL}${JAILED}${GIT_PROMPT} [${B_PURPLE}\w${NORMAL}] (${B_YELLOW}\A${NORMAL})"

	if [ ! -z "$WINDOW" ]; then
		PS1="${PS1}\n [${CYAN}W$WINDOW${NORMAL}]${SHTITLE}\$ "
	else
		PS1="${PS1}\n\$ "
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
alias s="tmux"
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

if [ "${OS}" = "linux" -o "${OS}" = "cygwin" ]; then
	alias colorls="/bin/ls -F --show-control-chars --color=always"
	alias dict="/usr/bin/dict"
	alias grep="/bin/egrep --mmap"
	alias mutt="/usr/bin/mutt -y"
	alias tar="env LANG=${_ENG_LOCALE} /bin/tar"
	alias top="/usr/bin/top -d 1"
fi

function gitdi() {
	git diff | perl -e '$p = $n = 0; while(<>) {if (/^-[^-]/) {$n++;} elsif (/^\+[^+]/) {$p++;}} printf("+%d -%d\n", $p,$n);'
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

# portmaster
if [ -f /usr/local/share/portmaster/bash-completions ]; then
	. /usr/local/share/portmaster/bash-completions
fi

test_ssh_agent() {
    ssh-add -l >/dev/null 2>&1
    if [ $? -eq 2 ]; then
        return 0
    fi
    return 1
}

# all kinds of bash completion
if [ -f "$HOME/.bashrc.git-completion" ]; then
    . $HOME/.bashrc.git-completion
fi

# local bashrc
if [ -r $HOME/.bashrc.local ]; then
	. $HOME/.bashrc.local
fi
