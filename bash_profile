
# added by Anaconda 2.2.0 installer
export PATH="/Users/slaffer/anaconda/bin:$PATH"

export CLICOLOR=1

PS1="\u@\[\e[32;1m\]\h\[\e[0m\]:\w\\$ "

alias ls='/bin/ls -G'
alias l='ls -lG'
alias ll='ls  -al | more -f'
alias lt='ls  -lGrt'
alias lz='ls  -lGrS'
alias lsd='ls  -d   */ .*/'
alias la='ls -laG'
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
