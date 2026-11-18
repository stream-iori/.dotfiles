# Repository Guidelines

## Project Structure

This directory contains the Neovim configuration for the dotfiles repository. `init.lua` handles startup and Neovide-specific settings, then loads `lua/config/lazy.lua` to bootstrap lazy.nvim and LazyVim.

| Path | What belongs here |
| --- | --- |
| `lua/config/` | Editor options, keymaps, autocommands, and shared Lua helpers |
| `lua/plugins/` | Plugin specs and overrides, with language settings in files such as `lang-python.lua` |
| `lazyvim.json` and `lazy-lock.json` | LazyVim extras and pinned plugin revisions |
| `spell/` | Custom English spell additions |
| `NEOVIM_*.md` and `IDEAVIM_CHEAT_SHEET.md` | Editor workflows and shortcut references |

## Development Commands

Run these commands from this directory. Link the checkout as your Neovim config directory (normally `~/.config/nvim`) so startup uses this checkout.

| Command | Purpose |
| --- | --- |
| `nvim --headless '+qa!'` | Smoke-test startup and inspect the output for errors. |
| `:checkhealth` | Diagnose plugin and dependency problems inside Neovim. Use `:Mason` to inspect managed tools. |
| `stylua --check init.lua lua` | Check Lua formatting with `stylua.toml`. |
| `markdownlint-cli2 AGENTS.md` | Lint this guide with the local Markdown rules. Substitute the path of any changed guide. |

## Coding Style

Use two-space indentation and a 120-column limit for Lua. Match neighboring modules, use descriptive file names such as `lang-rust.lua`, and give keymaps a clear `desc`. Update the relevant workflow guides when a shortcut or command changes. Review `lazy-lock.json` when changing plugin revisions.

## Testing

This configuration has no automated test suite or coverage target. After the startup check, open a representative file and exercise the affected behavior. For keymaps, verify each changed mode. For language tooling, check attachment, formatting, or diagnostics in the affected filetype.

## Commits and Pull Requests

Use a short subject that names the change, such as `Align IdeaVim and Neovim editing workflows`. Both plain subjects and scoped subjects such as `config(nvim): refine theme and terminal setup` appear in history. In pull requests, describe the behavior change and checks run, link relevant issues, and include screenshots for visual changes when helpful.
