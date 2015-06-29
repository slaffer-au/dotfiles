#  ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ "$PS1" ]; then    
    set -o emacs
    stty erase "^?"
fi

# Source global definitions first
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Change the window title of X terminals 
case $TERM in
    xterm*|rxvt*|Eterm)
#        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/   ~}\007"'
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        PS1="\u@\[\e[32;1m\]\h\[\e[0m\]:\w\\$ "
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/     ~}\033\\"'
        PS1="\u@\[\e[32;1m\]\h\[\e[0m\]:\w\\$ "
        ;;
    linux)
        PS1="\u@\[\e[32;1m\]\h\[\e[0m\]:\w\\$ "
        ;;
esac

#bdd 2007-12-07 09:07:40 - - - - - - - - - - - - - - - - - - - -
# change ls for bdianni
alias ls='/bin/ls -G'
alias l='ls -lG'
alias ll='ls  -al | more -f'
alias lt='ls  -lGrt'
alias lz='ls  -lGrS'
alias lsd='ls  -d   */ .*/'

alias cl='clear'
alias du1='du -h -d1'
alias duk='du -k -d1 | sort -n'
alias df='df -h'
alias ifc='ifconfig | more'

alias vi='vim'
alias vj='vim ~/.junk'
alias .d='open -a /Applications/MacVim.app /$HOME/notes/.daily.txt'
alias .g='open -a /Applications/MacVim.app /$HOME/notes/Guns/GunNotes.txt'
alias .h='open -a /Applications/MacVim.app /$HOME/notes/.home.txt'
alias .s='vi /$HOME/notes/system.txt'
alias .w='open -a /Applications/MacVim.app /$HOME/work/misc.txt'
alias .q='open -a /Applications/MacVim.app /$HOME/notes/Politics/Quotes.txt'

alias grinp='grep input\ err | grep -v 0\ input'

PATH="/usr/local/bin:$HOME/bin:/sbin:$PATH"
ENV=$HOME/.bashrc
USERNAME="bdianni"
TERM="xterm"
export USERNAME ENV PATH TERM

PS1=" \n\u@\[\e[32;1m\]\h\[\e[0m\]:\w $ "

if [[ "$TERM" != "screen" ]] && 
        [[ "$SSH_CONNECTION" == "" ]]; then
    # Attempt to discover a detached session and attach 
    # it, else create a new session

    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null; then
        tmux -2 attach-session -t $WHOAMI
    else
        tmux -2 new-session -s $WHOAMI
    fi
else

    # One might want to do other things in this case, 
    # here I print my motd, but only on servers where 
    # one exists

    # If inside tmux session then print MOTD
    MOTD=/etc/motd.tcl
    if [ -f $MOTD ]; then
        $MOTD
    fi
fi

#end
