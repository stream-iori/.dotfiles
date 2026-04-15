# ------------------------------------------------------------------------------
# 1. Network & Proxy
# ------------------------------------------------------------------------------

# Proxy management
# Uses variables from ~/.zshprivate if available, otherwise defaults to local ports
function proxy() {
  local http_port=${PROXY_HTTP_PORT:-6152}
  local socks_port=${PROXY_SOCKS_PORT:-6153}
  
  export http_proxy="http://127.0.0.1:$http_port"
  export https_proxy="http://127.0.0.1:$http_port"
  export all_proxy="socks5h://127.0.0.1:$socks_port"
  export ALL_PROXY="socks5h://127.0.0.1:$socks_port"
  
  echo "󱚽 Proxy enabled (HTTP: $http_port, SOCKS: $socks_port)"
}

function unproxy() {
  unset http_proxy https_proxy all_proxy ALL_PROXY
  echo "󱚼 Proxy disabled"
}

function local-ip() {
  local ip=$(ipconfig getifaddr en0)
  if [ -n "$ip" ]; then
    echo "$ip"
  else
    echo "No IP address found for en0"
  fi
}

# ------------------------------------------------------------------------------
# 2. Terminal Utilities
# ------------------------------------------------------------------------------

# Reset terminal sequences and mouse tracking
function rt() {
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l'
  reset
}

# ------------------------------------------------------------------------------
# 3. Toolchain Lazy Loading
# ------------------------------------------------------------------------------

# Lazy load SDKMAN to speed up shell startup
function sdk() {
  unfunction sdk
  if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
  else
    echo "SDKMAN not found at $SDKMAN_DIR"
  fi
}
