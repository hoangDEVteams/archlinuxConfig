export TERM=xterm-256color
#
# ===== NVM (đặt lên đầu) =====
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh

# ===== OH-MY-ZSH (nếu có) =====
#[[ -f "$ZDOTDIR/.ohmyzsh" ]] && source "$ZDOTDIR/.ohmyzsh"
#

# ===== SETTINGS =====
export EZA_ICONS=always
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
export HIST_IGNORE_PATTERN="clear|sudo *"

# ===== PLUGINS =====
[[ -f "/usr/bin/fzf" ]] && eval "$(/usr/bin/fzf --zsh)"

if [[ -f "/usr/bin/zoxide" ]]; then
  eval "$(/usr/bin/zoxide init zsh)"
fi

[[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ===== ALIAS =====
alias ls='eza --group-directories-first'
alias ll='eza -l --git'
alias la='eza -la'
alias lt='eza -lT --level=2'

# ===== PROMPT =====

autoload -Uz colors && colors

function set_prompt() {
  local icon=""
  local dir="%1~"
  local git_branch=""

  # lấy branch nếu có git
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch="($(git branch --show-current))"
  fi

  # icon theo thư mục
  case "$PWD" in
    "$HOME")
      icon=""
      ;;
    */Downloads*)
      icon="󰅢"
      ;;
    */mobileUI*)
      icon="󰊢"
      ;;
    *)
      icon=""
      ;;
  esac

  # màu random mỗi lần
  #local accent_colors=("#EDAFB8" "#F7E1D7" "#B0C4B1" "DEDBD2" "4A5759")
  #local rand_color=${accent_colors[$((RANDOM % ${#accent_colors[@]} + 1))]}

  #PROMPT="%F{$rand_color}> ( ${icon} ) ${dir} ${git_branch}%f "
  #
  local accent_colors=("#CDB4DB" "#FFC8DD" "#FFAFCC" "#D0F4DE" "#A2D2FF" "#A8DADC" "#ADC178")
  local rand_accent=${accent_colors[$((RANDOM % ${#accent_colors[@]} + 1))]}  # Cho mũi tên và Icon
  local rand_bracket=${accent_colors[$((RANDOM % ${#accent_colors[@]} + 1))]} # Cho dấu ngoặc ( )
  local rand_dir=${accent_colors[$((RANDOM % ${#accent_colors[@]} + 1))]}     # Cho tên thư mục

  local c_dark="#1D3557" # Giữ nguyên màu tối cho nhánh Git để dễ nhìn

  # Cấu trúc Prompt
  PROMPT="%F{${rand_accent}}❯%f %F{${rand_bracket}}(%f %F{${rand_accent}}${icon}%f %F{${rand_bracket}})%f %F{${rand_dir}}${dir}%f %F{${c_dark}}${git_branch}%f "
}

precmd_functions+=(set_prompt)
