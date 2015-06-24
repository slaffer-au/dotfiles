# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredupes

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy on git_branch 
# comment out  #barnaby 2014-12-01 10:33:35 - - - - - - - - - - - - - - - - - - - -
#if [ "$color_prompt" = yes ]; then
# PS1='${debian_chroot:+($debian_chroot)}\[\033[0;35m\]\u@\h\[\033[00m\]:\[\033[1;37m\]\w\[\033[00m\]\[\033[01;36m\]$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$ '

#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    #alias grep='grep --color=auto'
#    #alias fgrep='fgrep --color=auto'
#    #alias egrep='egrep --color=auto'
#fi

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# PS1=" \n\u@\[\e[32;1m\]\h\[\e[0m\]:\w $ "
# PS1=" \n\u@\[\e[32;1m\]\h\[\e[0m\]:\w \\$ "

function git_branch {
  git branch --no-color 2> /dev/null | egrep '^\*' | sed -e 's/^* //'
  }

function git_dirty {
    # only tracks modifications, not unknown files needing adds
if [ -z "`git status -s | awk '{print $1}' | grep '[ADMTU]'`" ] ; then
return 1
else
return 0
fi
}

function dirty_git_prompt {
branch=`git_branch`
if [ -z "${branch}" ] ; then
return
fi
git_dirty && echo " (${branch})"
}

function clean_git_prompt {
branch=`git_branch`
if [ -z "${branch}" ] ; then
return
fi
git_dirty || echo " (${branch})"
            }

zd() {
  case_number=$(echo $1 | awk -F'/' '{print $NF}')
  if [[ ! -d ~/cases/$case_number ]]; then
    mkdir ~/cases/$case_number
  fi
  cd ~/cases/$case_number
  touch .
  ls
}
zdd() {
  case_number=$(echo $1 | awk -F'/' '{print $NF}')
  zd $case_number
  download $case_number
}

#export PROMPT_DIRTRIM=3

#if [ "$color_prompt" = yes ]; then
#PS1='${debian_chroot:+($debian_chroot)}\[\033[0;35m\]\u@\h\[\033[00m\]:\[\033[1;37m\]\w\[\033[00m\]\[\033[01;36m\]$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$'

# two line.. full path
# PS1='\n${debian_chroot:+($debian_chroot)}\[\033[0;35m\][\w]\[\033[00m\]\[\033[01;33m\]\n\u@\[\e[32;1m\]\h\[\033[01;36m\]:$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$ '

# two line.. full path no space between lines
if ["$HOSTNAME" = 'roz'] : 
then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[0;35m\][\w]\[\033[00m\]\[\033[01;33m\]\n\u@\[\e[32;1m\]\h\[\033[01;36m\]:$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\[\033[0;35m\][\w]\[\033[00m\]\[\033[01;33m\]\n\u@\[\e[32;1m\]\h\[\033[01;31m\]:$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$ '
fi
#keep
#PS1='${debian_chroot:+($debian_chroot)}\n\u@\[\e[32;1m\]\h\[\033[00m\]:\[\033[1;37m\]\w\[\033[00m\]\[\033[01;36m\]$(dirty_git_prompt)\[\033[1;36m\]$(clean_git_prompt)\[\033[00m\]\$ '
 
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
      PATH="$HOME/bin:$PATH"
fi


 
#end

