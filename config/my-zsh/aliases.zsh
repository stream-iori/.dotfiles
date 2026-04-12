# ------------------------------------------------------------------------------
# 1. Standard Replacements
# ------------------------------------------------------------------------------
alias vim="nvim"
alias ls="ls --color"
alias ll="ls --color -lh"
alias la="ls --color -A"
alias l="ls --color -CF"
alias lgit="lazygit"

# ------------------------------------------------------------------------------
# 2. Network & Utilities
# ------------------------------------------------------------------------------
alias local-ip="ipconfig getifaddr en0"
alias proxy='export http_proxy=http://127.0.0.1:6152; export https_proxy=http://127.0.0.1:6152; export all_proxy=socks5h://127.0.0.1:6153; export ALL_PROXY=socks5h://127.0.0.1:6153'
alias unproxy='unset all_proxy ALL_PROXY http_proxy https_proxy'
alias rt="printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l'; reset"

# ------------------------------------------------------------------------------
# 3. Development Tools
# ------------------------------------------------------------------------------
# Zoxide
if (( $+commands[zoxide] )); then
  alias j='__zoxide_z'
  alias jj='__zoxide_zi'
fi

# ------------------------------------------------------------------------------
# 4. Custom Functions
# ------------------------------------------------------------------------------
# Obsidian Quick-open
unalias ob 2>/dev/null
function ob() {
  local target_dir=$(pwd)
  local folder_name=${1:-$(basename "$target_dir")}
  local vault_name=$(basename "$OBSIDIAN_MAIN_VAULT")
  local link_dir="$OBSIDIAN_MAIN_VAULT/External"
  
  mkdir -p "$link_dir"
  [[ -d "$OBSIDIAN_MAIN_VAULT/.obsidian" ]] || mkdir -p "$OBSIDIAN_MAIN_VAULT/.obsidian"
  ln -shf "$target_dir" "$link_dir/$folder_name"
  
  local encoded_vault=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$vault_name")
  local encoded_path=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "External/$folder_name")
  
  echo "Linking $(basename "$target_dir") as '$folder_name' to $vault_name..."
  open "obsidian://open?vault=$encoded_vault&path=$encoded_path"
}
