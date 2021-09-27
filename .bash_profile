#
# ~/.bash_profile
#

# Add ~/bin to the head of $PATH
export PATH=~/bin:${PATH}

# Apply settings in the .bashrc file
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

###############################################################################
#####  Add your local SSH private keys to the SSH agent and start it      #####
#####  cf https://gist.github.com/Perigrinox/git bash ssh agent.md        #####
###############################################################################
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
