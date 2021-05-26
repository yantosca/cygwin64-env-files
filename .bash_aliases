#------------------------------------------------------------------------------
#                  GEOS-Chem Global Chemical Transport Model                  !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: .bash_aliases
#
# !DESCRIPTION: A .bashrc-style file that you can use to contain your own
#  personal settings for Git-bash on Windows.  Contains useful settings for
#  connecting to the Amazon Web Services cloud computing environment.
#  Feel free to add/change/remove any of these settings as you wish.
#\\
#\\
# !CALLING SEQUENCE:
#  source ~/.bash_aliases
#  (will also be called each time you source ~/.bashrc)
#
# !AUTHOR
#  Bob Yantosca (yantosca@seas.harvard.edu), 20 Dec 2018
#
# !REVISION HISTORY: 
#  Use the gitk browser to view the revision history!
#EOP
#------------------------------------------------------------------------------
#BOC

#==============================================================================
# %%%%% Personal settings: Specific to Cygwin64 %%%%%
#==============================================================================

# Alias xterm to mintty
alias xterm=mintty

# Force emacs to start by loading the .emacs file
# This is only needed for Cygwin64 on Windows 10
alias emacs="emacs -q --eval '(setq alt-conf t)' --load ~/.emacs"

#==============================================================================
# %%%%% Personal settings: Look-and-feel %%%%%
#==============================================================================

# Override the system prompt (93 = yellow)
PS1="\[\e[1;93m\][\h \W]$\[\e[0m\] "

# Settings for colorization
export GREP_COLOR=32
export LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;37:*.tgz=01;37:*.arj=01;37:*.taz=01;37:*.lzh=01;37:*.zip=01;37:*.z=01;37:*.Z=01;37:*.gz=01;37:*.bz2=01;37:*.deb=01;37:*.rpm=01;37:*.jar=01;37:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

#==============================================================================
# %%%%% Personal settings: Basic Unix commands %%%%%
#==============================================================================

# General Unix commands
alias disk="du -h -s -c"
alias emacs="emacs 2>/dev/null"
alias g="grep -in --color=auto"
alias gt="grep -in --text"
alias m="less -CR"
alias me="xterm 2>/dev/null &"
alias proc="ps -ef | grep $USER | sort"
alias pu="rm *~"
alias pua="rm .*~"
alias sb=". ~/.bashrc"
alias sba=". ~/.bash_aliases"
alias tf="tail --follow"
alias zap="kill -9"
alias cd="cd -P"
alias c="clear"
alias h="history"
alias diff="colordiff"
alias rm="rm -Iv"
alias rmcore="rm core.*"
alias cp="cp -v"
alias mv="mv -v"
alias ssh="ssh -YA"                         # Trusted X11 + agent forwarding
alias ssh_pf="ssh -L 8999:localhost:8999 "  # Port forwarding

# Directory listing commands
alias ls="ls -CF --time-style=long-iso --color=auto"
alias l1="ls -1"
alias ll="ls -l"
alias llt="ls -lt"
alias lltm="ls -lt | less"
alias la="ls -a"
alias lla="ls -la"
alias llh="ls -lh"

# Tmux aliases
alias tmuxnew="tmux new -s "
alias tmuxat="tmux a -t "
alias tmuxde="tmux detach "

function dos2unix() {
    ##### Convert a windows file to Unix #####
    awk '{ sub("\r$", ""); print }' $1 > $2
}

#==============================================================================
# %%%%% Personal settings: Git commands %%%%%
#==============================================================================

# Basic Git commands
alias gui="git gui 2>/dev/null &"
alias gk="gitk 2>/dev/null &"
alias gka="gitk --all 2>/dev/null &"
alias gpo="git pull origin"
alias gl="git log"
alias glo="git log --oneline"
alias glp="git log --pretty=format:'%h : %s' --topo-order --graph"
alias update_tags="git tag -l | xargs git tag -d && git fetch -t"

function gbup() {
    ###### Set a branch to follow a remote branch #####
    git branch --set-upstream-to=origin/${1} ${1}
}

function gbrd() {
    ###### Remove remote branches #####
    git branch -r -d origin/$1
}

function gprune() {
    ##### Remove local and remote branches #####
    git branch -d $1
    gbrd $1
}

function ghgc() {
    ##### Clone a repo from github.com/geoschem #####
    git clone git@github.com:geoschem/${1}.git
}
function ghy() {
    ##### Clone a repo from github.com/yantosca #####
    git clone git@github.com:yantosca/${1}.git
}

# Git aliases for GEOS-Chem
#source /etc/bash_completion.d/git
alias clone_gcc="git clone git@github.com:geoschem/GCClassic.git"
alias clone_gchp="git clone git@github.com:geoschem/gchp.git"
alias clone_hco="git clone git@github.com:geoschem:hemco.git"
alias gitc="git -C CodeDir"
alias glog="git -C src/GEOS-Chem log --oneline"
alias gsu="git submodule update --init --recursive"
alias hlog="git -C src/HEMCO log --oneline"
alias hplog="git -C src/GCHP_GridComp/HEMCO_GridComp/HEMCO log --oneline"

#==============================================================================
# %%%%% Personal settings: Harvard logins %%%%%
#==============================================================================

# Log into AS
alias bmygo="ssh bmy@bmy.as.harvard.edu"

# Log into FASRC (login node assigned at ranndom)
alias rcgo="ssh ryantosca@login.rc.fas.harvard.edu"

function hgo() {
    ##### Log into a holylogin node #####
    node=$(printf %02d $1)
    ssh ryantosca@holylogin${node}.rc.fas.harvard.edu
}

#==============================================================================
# %%%%% Personal settings: AWS cloud %%%%%
#==============================================================================

# Amazon S3 commands
alias s3copy="aws s3 cp -request-payer=requester "
alias s3ls="aws s3 ls -request-payer=requester "

function awsgo() {
    ##### Log into an AWS instance #####
    ssh ubuntu@${1}
}

#==============================================================================
# %%%%% Compilers %%%%%
#==============================================================================
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export FC=/usr/bin/gfortran

##==============================================================================
## ## %%%%% Personal Settigns: Python %%%%%
## Note, we usually don't install a Python stack on cygwin
## but you can uncomment these if so desired.
##==============================================================================
#
## Select Bob Y's custom environment (matplotlib 3)
#alias sab="conda activate bmy"
#alias sdb="conda deactivate"
#
## Add Python repos to $PYTHONPATH
#export PYTHONPATH=${PYTHONPATH}:${HOME}/python/gcpy
#
## Ignore warnings about deprecated options
#export PYTHONWARNINGS=ignore::DeprecationWarning
#
## Settings for Python packages
#export PYLINTRC=~/.pylint.rc
#
## Temporary Python folder (avoids warning messages)
#export XDG_RUNTIME_DIR=/tmp/runtime-${USER}
#
#EOC
