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
# Define some important local aliases
#==============================================================================

# Change to home directory
cd ~

# Load personal customizations
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi
#EOC
