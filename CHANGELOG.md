# Changelog

All notable changes to this dotfiles repository will be documented in this file.

## [2026-04-04] - Zsh & Zellij Final Optimization

### Added
- **Obsidian Integration**:
    - Implemented a robust `ob` function in `zshrc` to quickly open any folder as an Obsidian vault.
    - Automatic symlinking to `~/Documents/Notes/External/` to satisfy Obsidian's security checks while maintaining a clean file structure.
    - Supports custom folder naming: `ob "MyCustomName"`.
- **Zellij Improvements**:
    - Mapped **`Ctrl + [`** to **`Esc`** globally for seamless mode switching.
    - Added **`v`** shortcut in `pane` mode for vertical splitting.
    - Enabled **`session_serialization`**, **`copy_command "pbcopy"`**, and **`on_force_close "detach"`** for a superior macOS experience.
    - **Keyboard Compatibility**: Explicitly disabled `support_kitty_keyboard_protocol` to prevent broken escape sequences (e.g., `14;5u`) during session reconnection.
- **Navigation (zoxide)**:
    - Reconfigured zoxide aliases to **`j`** and **`jj`** to match the popular `autojump` muscle memory for quick directory hopping and interactive search.
- **Alacritty Optimization**:
    - Refactored `alacritty.toml` into a modular, modern structure.
    - Enabled `save_to_clipboard` for seamless copy-on-select.
    - Standardized `TERM=xterm-256color` in `zshenv` for better SSH/terminal compatibility.
    - Added `COLORTERM=truecolor` to ensure 24-bit color support for modern tools.
    - Enhanced UI with cursor blinking and refined padding.
    - Fixed `Ctrl + Return` behavior to ensure standard terminal sequences.
- **Atuin Interaction & UI**:
    - Created a dedicated `config.toml` for Atuin in the dotfiles repository.
    - Configured `date_format = "%Y-%m-%d %H:%M"` to prevent time/seconds from flickering and ticking in the UI.
    - Set `enter_accept = false` to allow users to edit the selected command in the shell prompt before execution.
    - Adjusted `inline_height = 15` and `style = "compact"` for a cleaner, non-intrusive terminal experience.
    - Fixed `[stats]` configuration to match the latest Atuin schema (replacing the deprecated boolean `stats` key).
- **Zsh Smart Options**:
    - Enabled **`autocd`**: Navigate to directories by just typing their name.
    - Enabled **`autopushd`**: Automatically maintain a directory stack for easy `popd` navigation.

### Optimized
- **Zsh Completion Engine Fix**:
    - Re-introduced explicit `compinit` initialization to resolve issues where `cd` and other command completions were failing.
    - Adjusted plugin loading order: `zsh-completions` -> `compinit` -> `fzf-tab` (synchronous loading for core completion logic to ensure reliability).
    - Kept `zsh-autosuggestions` and `fast-syntax-highlighting` as asynchronous for optimal startup performance.
- **FZF Modernization**:
    - Global `FZF_DEFAULT_OPTS` with a modern, border-aware UI and layout.
    - Switched `FZF_DEFAULT_COMMAND` to `fd` for faster, git-aware file discovery.
    - Migrated to `eval "$(fzf --zsh)"` for cleaner keybindings and completion initialization.
- **UI & UX**:
    - Restored `bindkey -e` and `Ctrl+A/E` for consistent Emacs-style line editing.
    - **Modernized Proxy Aliases**: Reconfigured `proxy` to use `socks5h` on port 6153 (remote DNS) and `http/https` on port 6152 via `all_proxy`.
    - Refactored `zshrc` into modular sections for better maintainability.

### Removed
- **Redundant Config**: Cleaned up legacy `conda`, `LLVM/C++`, and `Java (JDK)` environment variables.
- **Legacy Plugins**: Removed `zsh-autopair` and duplicate `zsh-completions`.
- **Aliases**: Removed `cat="bat"` and `za` aliases to keep the environment minimal.

## [2026-04-04] - Initial Modernization
*(Previous entries omitted for brevity)*
