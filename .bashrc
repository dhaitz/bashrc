#-------------------------------------------------------------
# OS-specific settings
#-------------------------------------------------------------

if [[ $OSTYPE == *"darwin"* ]]; then
    export PATH=/Users/dhaitz/.homebrew/bin:$PATH
    alias ls=gls
    alias readlink=greadlink
    alias dircolors=gdircolors
	alias zcat=gzcat
	alias shuf=gshuf
    export LS=gls
	# [ -f /Users/dhaitz/.homebrew/etc/bash_completion ] && . /Users/dhaitz/.homebrew/etc/bash_completion
	LESSPIPE=`which src-hilite-lesspipe.sh`
	export LESSOPEN="| ${LESSPIPE} %s"
	export LESS=' -R '
	alias rm='safe-rm'
	alias tm='open -a TextMate'
else
    export LS=/bin/ls
fi
alias ls=${LS}

#-------------------------------------------------------------
# Aliases
#-------------------------------------------------------------

#if hash trash 2>/dev/null; then
#	alias rm='trash'
#fi


# create folder and move into it
mkcd () {
  mkdir "$1"
  cd "$1"
}

# cd's
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'

alias lesss='less -S'
alias wcl='wc -l'
alias cdd='cd ~/Desktop'

# git
alias gs="git status"
alias gc="git commit"
gcm() {
	git commit -m "$*"
}
alias gca="git commit --amend --no-edit"
alias ga="git add"
alias gau="git add -u"
alias gap="git add -p"
alias gaA="git add -A"
alias gd="git diff"
alias gk='gitk --all &'
alias gr="git rebase"
alias gf="git fetch"

export FLEX_HOME=~/bin/flex
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export PYTHONIOENCODING=utf-8
 
#-------------------------------------------------------------
# Prompt
#-------------------------------------------------------------
export PS1HOSTCOLOR='1;33'
export PS1='\[\033[${PS1HOSTCOLOR}m\][$(date +%H:%M)] \[\033[1;34m\]\w\[\e[m\]$(parse_git_branch_and_add_brackets) \[\033[1;32m\]\$\[\033[00m\] '


#-------------------------------------------------------------
# Set terminal title
#-------------------------------------------------------------
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'


#-------------------------------------------------------------
# The 'ls/ll' family (use a recent GNU ls).
#-------------------------------------------------------------
alias la='ls -A'           #  Show (a)ll hidden files
alias l='ls -CF'           #  Column output + indicator
alias lx='ls -lXB'         #  Sort by e(x)tension.
alias lk='ls -lSr'         #  Sort by size (biggest last)
alias lt='ls -ltr'         #  Sort by (t)ime (date, most recent last).
alias lc='ls -ltcr'        #  Sort by (c)hange (most recent last)
alias lu='ls -ltur'        #  Sort by (u)sage/access (most recent last).
# ll: directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through '(m)ore'
alias lr='ll -R'           #  (R)ecursive ll.
alias lla='ll -A'          #  Show (a)ll hidden files.
alias tree='tree -C' #  Alternative to 'recursive ls' ...


#-------------------------------------------------------------
# Terminal colors
#-------------------------------------------------------------
[ -f "$BASHRCDIR/dir_colors" ] && eval `dircolors $BASHRCDIR/dir_colors` || eval `dircolors -b`

if hash dircolors 2>/dev/null || hash gdircolors 2>/dev/null; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='${LS} -h --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='${LS} -h'
fi
alias diff='colordiff'


#-------------------------------------------------------------
# Less colored output
#-------------------------------------------------------------
if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
	export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
	export LESS=' -R '
fi
alias lesss='less -S'


#-------------------------------------------------------------
# Grep
#-------------------------------------------------------------
# The following 3 are defined by default
# alias rgrep='grep -r'    # (r)ecursive grep
# alias fgrep='grep -F'    # (F)ixed string list
# alias egrep='grep -E'    # (E)xtended Regex
alias igrep='grep -i'      # case (i)nsensitive
#export GREP_OPTIONS='--color=auto'


#-------------------------------------------------------------
# history
#-------------------------------------------------------------
if ((BASH_VERSINFO[0] >= 4)) && ((BASH_VERSINFO[1] >= 3)); then
	export HISTFILESIZE=-1
	export HISTSIZE=-1
else
	export HISTFILESIZE=100000
	export HISTSIZE=5000
fi

export HISTFILE=$HOME/.bash_history
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize
alias h='history'
alias hg='history | grep'


#-------------------------------------------------------------
# Git
#-------------------------------------------------------------
function parse_git_branch_and_add_brackets {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}
[ -f $BASHRCDIR/git-completion.bash ] && source $BASHRCDIR/git-completion.bash

#export PS1='\[\e[${PS1HOSTCOLOR}m\][$(date +%H:%M)] \h:\[\e[m\]\[\e[1;34m\]\w\[\e[m\]$(parse_git_branch_and_add_brackets) \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]\[\033[00m\]'


#-------------------------------------------------------------
# Source specific dhaitz bashrc files if exist
#-------------------------------------------------------------
if [ -e ~/.bashrc_dhaitz_* ]; then
    . ~/.bashrc_dhaitz_*
fi



#-------------------------------------------------------------
# Decompress files
#-------------------------------------------------------------

extract () {
	if [ -f $1 ]  ; then
		case $1 in
			*.tar.bz2) tar xvjf $1   ;;
			*.tar.gz)  tar xvzf $1   ;;
			*.bz2)     bunzip2 $1    ;;
			*.rar)     unrar x $1    ;;
			*.gz)      gunzip $1     ;;
			*.tar)     tar xvf $1    ;;
			*.tbz2)    tar xvjf $1   ;;
			*.tgz)     tar xvzf $1   ;;
			*.zip)     unzip $1      ;;
			*.Z)       uncompress $1 ;;
			*.7z)      7z x $1       ;;
			*)         echo "unrecognized file extension" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
