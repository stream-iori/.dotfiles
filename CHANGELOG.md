# Changelog

All notable changes to this dotfiles repository will be documented in this file.

## [2026-04-04] - Zsh & Zellij Final Optimization

### Added
- **Obsidian Integration**:
    - Implemented a robust `ob` function in `zshrc` to quickly open any folder as an Obsidian vault.
    - Automatic symlinking to `~/Documents/Notes/External/` to satisfy Obsidian's security checks while maintaining a clean file structure.
    - Supports custom folder naming: `ob "MyCustomName"`.
- **Zellij Improvements**:
    - Mapped `Ctrl + [` to `Esc` globally for seamless mode switching.
    - Added `v` shortcut in `pane` mode for vertical splitting.
    - Preserved `h, j, k, l` for Vim-style navigation within panes.

### Optimized
- **Zsh Startup & Performance**:
    - **PATH Refactor**: Migrated to Zsh-native `path=(...)` array with `typeset -U path` for automatic deduplication and cleaner precedence management.
    - **Async Loading**: Leveraged Zinit `wait'0' lucid` for all core plugins and integrations (including `atuin` and `fzf-tab`).
    - **Eval Caching**: Optimized `atuin` and `fzf` initialization to minimize shell startup latency.
    - **Compinit**: Removed manual `compinit` calls in favor of Zinit's more efficient completion management.
- **FZF Modernization**:
    - Global `FZF_DEFAULT_OPTS` with a modern, border-aware UI and layout.
    - Switched `FZF_DEFAULT_COMMAND` to `fd` for faster, git-aware file discovery.
    - Migrated to `eval "$(fzf --zsh)"` for cleaner keybindings and completion initialization.
- **UI & UX**:
    - Restored `bindkey -e` and `Ctrl+A/E` for consistent Emacs-style line editing.
    - Refactored `zshrc` into modular sections (Base, Plugins, Aliases, Options, Integrations) for better maintainability.
    - **Modernized Proxy Aliases**: Reconfigured `proxy` to use `socks5h` on port 6153 (enabling remote DNS resolution) and `http/https` on port 6152 via `all_proxy` for maximum tool compatibility.

### Removed
- **Redundant Config**: Cleaned up legacy `conda`, `LLVM/C++`, and `Java (JDK)` environment variables in favor of modern tools like `SDKMAN`.
- **Legacy Plugins**: Removed `zsh-autopair` and duplicate `zsh-completions` to keep the environment lean.
- **Old FZF**: Removed manual `~/.fzf.zsh` sourcing.

## [2026-04-04] - Initial Modernization
*(Previous entries omitted for brevity)*
