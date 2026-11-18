# Repository Guidelines

## Project Structure

- `config/` contains app settings, including Neovim, Ghostty, Kitty, Herdr, and shell helpers under `config/my-zsh/`. Keep Neovim keymaps and core settings in `config/nvim/lua/config/`, and plugin specs in `config/nvim/lua/plugins/`.
- `symlink/` and `git/` hold home-directory dotfiles. Files named `*.symlink` install as hidden files in `$HOME`. Karabiner rules live in `karabiner/assets/complex_modifications/`.
- `scripts/` contains setup and maintenance tools. Neovim and IdeaVim workflow guides live in `config/nvim/`.

## Setup and Validation

There is no repository-wide build, automated test suite, or coverage target. Run syntax checks on changed scripts, then verify the affected behavior in its application.

| Command | Use |
| --- | --- |
| `bash scripts/link.sh` | Install dotfile links into your home directory. This changes live configuration and may move existing targets to `.bak`; use a disposable home when testing the installer. |
| `bash -n scripts/link.sh` | Check a Bash script without running it. |
| `zsh -n symlink/zshrc.symlink` | Check Zsh syntax without sourcing the file. |
| `nvim --headless '+qa!'` | Smoke-test the linked Neovim config. For plugin or keymap changes, also run `:checkhealth` or exercise the mapping in Neovim. |
| `git diff --check` | Check the diff for whitespace errors. |

## Style and Naming

- Match neighboring files and keep changes scoped to the relevant app. Use two-space Lua indentation and the 120-column target in `config/nvim/stylua.toml`; check changed Lua files with StyLua. Follow `config/nvim/.markdownlint-cli2.yaml` for Neovim Markdown.
- Update the relevant workflow guide when a shortcut or command changes. Never add credentials, runtime state, or machine-specific symlinks. Keep an app’s `.link-files` marker when it needs a real config directory for local state.

## Commits and Pull Requests

Use a short, descriptive subject naming the app and change, such as `Add TinyCast configuration`. Recent history uses plain subjects rather than a mandatory prefix. For pull requests, explain what changes and why, list the checks run, and call out relinking or migration steps. Link relevant issues and include a screenshot only when it helps review a visual change.
