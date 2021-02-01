#------------------------------------------------------------------------------
#                 GEOS-Chem Global Chemical Transport Model                  !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: .bashrc
#
# !DESCRIPTION: A .bashrc file that can be used with Cygwin64 for Microsoft
#  Windows.  This initializes your Unix environment, starts the ssh-agent
#  for private-key forwarding, and loads personal aliases in your
#  .bash_aliases file.
#\\
#\\
# !CALLING SEQUENCE:
#  source ~/.bashrc
#
# !REMARKS:
#  (1) Add/change/remove settings to customize your Cygwin64 Unix environment.
#
#  (2) Your root folder (~) will be C:/cygwin64/home/YOUR-WINDOWS-SCREEN-NAME,
#      where YOUR-WINDOWS-SCREEN-NAME is the name that you log into MS
#      Windows with.
#
#  (3) SSH private keys should be stored in the folder
#      C:/cygwin64/YOUR-WINDOWS-SCREEN_NAME/.ssh (aka ~/.ssh).
#
# !AUTHOR
#  Bob Yantosca (yantosca@seas.harvard.edu), 02 Aug 2019
#
# !REVISION HISTORY: 
#  Use the gitk browser to view the revision history!
#EOP
#------------------------------------------------------------------------------
#BOC

#==============================================================================
# Define personal settings that will be used below (edit these yourself)
#==============================================================================

# Define the user name. This should set to YOUR-WINDOWS-SCREEN-NAME.
export USER=Bob

# Set the display variable
if [[ "x$DISPLAY" == "x" ]]; then
   export DISPLAY=:0.0
fi

#==============================================================================
# Define the path to SSH private keys that you would like to be forwarded
# using ssh-agent.  Then start the ssh-agent if it isn't already running.
#==============================================================================
key_1=~/.ssh/bmy_aws_keypair.pem
key_2=~/.ssh/id_rsa_20181218

# ssh-agent config file
env=~/.ssh/agent.env

agent_load_env() {
    ##### Load the ssh-agent config file #####
    test -f "$env" && . "$env" >| /dev/null ;
}

agent_start() {
    ##### Start ssh-agent if it's not running #####
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

# Call the function to load ssh-agent
agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

# Add a new ssh-add command for all of the private keys
# that you want to be forwarded with ssh-agent!
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ${key_1}
    ssh-add ${key_2}
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ${key_1}
    ssh-add ${key_2}
fi

# Free local variables
unset env
unset key_1
unset key_2

#==============================================================================
# Define some important local aliases
#==============================================================================

# Change to home directory
cd ~

# Load personal customizations
if [[ -f ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi
#EOC
