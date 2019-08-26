# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="/usr/local/texlive/2018/bin/x86_64-linux:$HOME/bin:$HOME/bin/kube:$HOME/.local/bin:/opt/jetbrains/intellij/bin/:/snap/bin:/opt/eclipse/java-oxygen/eclipse/:/opt/Visual_Paradigm_15.0/bin/:$PATH"


. /home/bw/dev/lua/torch/install/bin/torch-activate
