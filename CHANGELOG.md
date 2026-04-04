# Changelog

All notable changes to this dotfiles repository will be documented in this file.

## [2026-04-04] - Terminal Environment Modernization

### Added
- **Zoxide Integration**: Replaced `autojump` with `zoxide` (Rust-based) for faster directory navigation.
- **Atuin Support**: Integrated `atuin` for modern, encrypted, and searchable shell history management.
- **Improved Syntax Highlighting**: Migrated to `fast-syntax-highlighting` for better performance and accuracy.
- **Zellij Layout**: Configured `compact-top` as the default layout to keep status information at the top.
- **Safety Measures**: Added `IGNOREEOF=2` to zsh to prevent accidental shell exits with `Ctrl-d`.

### Changed
- **Zsh Configuration Refactor**: 
    - Decoupled `zshenv` (core environment) and `zshrc` (interactive features).
    - Moved all interactive aliases and UI-related settings to `zshrc`.
    - Removed redundant `TERM` exports and dynamic login calculations to speed up shell startup.
    - All internal comments in `zshenv` and `zshrc` have been translated to English for better maintainability.
- **Zellij Keybindings**:
    - Unified the rename action to `r` for both Tabs and Panes.
    - Rebound `Ctrl + q` from `Quit` to `Detach` to prevent accidental session termination.

### Removed
- **Legacy Tools**: Completely removed `autojump` configuration and its Zinit plugin.
- **Redundant Plugins**: Removed `OMZ::lib/history.zsh` and `OMZ::plugins/fzf` to avoid conflicts with `atuin`.
- **Zellij Built-in Compact**: Reverted to custom `compact-top` as the built-in `compact` does not support top-alignment.

### Optimized
- **PATH Construction**: Standardized PATH building logic in `zshenv` to ensure predictable tool precedence (GNU/Homebrew tools first).
- **Startup Speed**: Significantly reduced the number of system calls during zsh initialization by removing dynamic command executions from `zshenv`.
