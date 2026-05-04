export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

#---------------------------------------
plugins=(git docker sudo)
source $ZSH/oh-my-zsh.sh
for file in ~/.zsh.d/*.zsh; do source "$file"; done
