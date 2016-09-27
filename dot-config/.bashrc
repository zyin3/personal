# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


alias e='emacs -nw'

alias apiary='cd java/com/google/api/server'
alias bb='blaze build --experimental_deps_ok'
alias build_copier='/google/data/ro/projects/build_copier/build_copier'
alias g3='cd /google/src/cloud/zyin/apiarycodelab/google3'
alias sng='synergys -f --config $HOME/synergy.conf'
alias docwiz=/google/data/rw/projects/apiserving/tools/docwizard.sh
alias libb='blaze-bin/java/com/google/api/server/examples/library/LibraryServer'
alias blr='/google/src/head/depot/google3/devtools/blaze/scripts/blaze-run.sh'
alias apido=/google/data/ro/teams/oneplatform/apido
alias placer=/google/data/ro/projects/placer/placer
alias fileutil=/google/data/ro/projects/placer/fileutil
alias inception_tool=/google/data/ro/teams/oneplatform/inception_tool
alias inception=/google/data/ro/teams/oneplatform/inception_push
alias inception_cli=/google/data/ro/teams/oneplatform/inception_cli
alias gcurl='curl -H "$(oauth2l header cloud-platform)" -H "Content-Type: application/json"'

export clab='java/com/google/api/server/config/examples/library'
export P4EDITOR='emacs -nw'
export P4MERGE='meld'
export EDITOR='emacs -nw'
export P4DIFF='meld'
export GIT_EDITOR='emacs -nw'
export jcg='java/com/google'
export jcga='java/com/google/api'
export jcgas='java/com/google/api/server'
export jtcg='javatests/com/google'
export jtcga='javatests/com/google/api'
export jtcgas='javatests/com/google/api/server'
export lae="http://localhost:8787"
export eclipse="../magicjar/eclipse/bin/"

export HEAD='/google/src/head/depot/google3/tools/'
export expr='experimental/users/zyin'
export GOPATH='/usr/local/google/home/zyin/gopath:/google/src/cloud/zyin/inception/google3/blaze-bin/'
export GOROOT='/usr/local/go'
export PATH=$PATH:~/bin:$GOROOT/bin

function getcl() {
  /usr/bin/srcfs get_readonly
}

function spansql_test() {
  span sql /span/nonprod/apiserving-dev:inception
}

function spansql_prod() {
  span sql /span/global/apiserving-spanner:inception
}

function tokeninfo() {
  curl "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$1"
}
