export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
eval "$(zoxide init zsh)"

#---------------------------------------

source $ZSH/oh-my-zsh.sh
for file in ~/.zsh.d/*.zsh; do source "$file"; done

# fastfetch
fastfetch
