# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/joseph/.oh-my-zsh"

ZSH_THEME="bureau"

plugins=(git kubectl)

# If not here then the profile only gets added on login; ssh
source ~/.zprofile

source $ZSH/oh-my-zsh.sh