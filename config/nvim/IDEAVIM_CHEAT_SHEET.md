# IdeaVim 速查手册

本文档对应当前 `~/.ideavimrc`，适用于 IntelliJ IDEA 与 PyCharm。Leader 为 `<Space>`。

配置目标是与 [Neovim / LazyVim](./NEOVIM_CHEAT_SHEET.md) 保持相同的操作语义；JetBrains 界面与 Neovim 插件界面不要求完全一致。

## 日常高频

| 功能 | 快捷键 |
| --- | --- |
| 保存 | `<C-s>` |
| 快速跳转 | `s` 后输入两个目标字符 |
| 查找项目文件 | `<leader><space>` / `<leader>ff` |
| 全局文本搜索 | `<leader>/` / `<leader>sg` |
| 切换最近编辑器 | `<leader>,` |
| 打开项目树 | `<leader>e` |
| 跳转定义 / 查找引用 | `gd` / `gr` |
| 跳转实现 / 类型定义 | `gI` / `gy` |
| Code Action / 重命名 | `<leader>ca` / `<leader>cr` |
| 格式化 / 整理导入 | `<leader>cf` / `<leader>co` |
| 上一个 / 下一个诊断 | `[d` / `]d` |
| 运行当前位置 / 重跑上次 | `<leader>tr` / `<leader>tl` |

`s` 有意覆盖 Vim 原生的 substitute 命令，以保持与 Neovim Flash 一致。需要删除字符并进入 Insert 模式时可使用 `cl`。

## 文件、Buffer 与搜索

| 功能 | 快捷键 | JetBrains 对应界面 |
| --- | --- | --- |
| 查找项目文件 | `<leader><space>` / `<leader>ff` | Go to File |
| 最近文件 | `<leader>fr` | Recent Files |
| 切换编辑器 | `<leader>,` | Switcher |
| 上一个 / 下一个编辑器标签 | `[b` / `]b` | Previous / Next Editor Tab |
| 关闭当前编辑器 | `<leader>bd` | Close Content |
| 项目树 | `<leader>e` | Project Tool Window |
| 全局文本搜索 | `<leader>/` / `<leader>sg` | Find in Files |

## 代码导航与编辑

| 功能 | 快捷键 |
| --- | --- |
| 跳转定义 | `gd` |
| 查找引用 | `gr` |
| 跳转实现 | `gI` |
| 跳转类型定义 | `gy` |
| 查看文档 | `K` |
| 参数信息 | `gK` |
| Code Action / Intentions | `<leader>ca` |
| 重命名符号 | `<leader>cr` |
| 整理导入 | `<leader>co` |
| 格式化 | `<leader>cf` |

注释与包裹沿用 IdeaVim 插件提供的 Vim 语义：

| 功能 | 快捷键 | 示例 |
| --- | --- | --- |
| 注释当前行 | `gcc` | `gcc` |
| 注释选区或 motion | `gc` | `gcap` |
| 包裹 motion | `ys{motion}{char}` | `ysiw"` |
| 包裹整行 | `yss{char}` | `yss)` |
| 删除包裹 | `ds{char}` | `ds"` |
| 修改包裹 | `cs{old}{new}` | `cs"'` |
| 包裹 Visual 选区 | `S{char}` | Visual 选择后按 `S}` |

## 诊断、Git 与测试

诊断：

| 功能 | 快捷键 |
| --- | --- |
| 显示光标处错误说明 | `<leader>cd` |
| 上一个 / 下一个诊断 | `[d` / `]d` |
| 打开 Problems | `<leader>xx` |

Git：

| 功能 | 快捷键 |
| --- | --- |
| VCS 操作菜单 | `<leader>gg` |
| Commit / 变更工具窗口 | `<leader>gs` |
| 当前文件历史 | `<leader>gf` |
| 当前文件逐行归因 | `<leader>gb` |
| 上一个 / 下一个 VCS 变更 | `[h` / `]h` |

测试与运行：

| 功能 | 快捷键 |
| --- | --- |
| 运行光标所在上下文 | `<leader>tr` |
| 重跑上一次 | `<leader>tl` |
| 停止运行 | `<leader>tS` |

具体运行粒度由 JetBrains 当前光标位置及可用 Run Configuration 决定；这对应 Neovim 的“运行最近测试”，但不模拟 Neotest 面板。IdeaVim 不设置 `<leader>tt`，因为 IDEA 与 PyCharm 没有稳定、通用且严格等价的“运行当前文件”动作。

## 编辑器分屏

| 功能 | 快捷键 |
| --- | --- |
| 水平分屏 | `<leader>-` |
| 垂直分屏 | `<leader>\|` |
| 关闭当前分屏 | `<leader>wd` |
| 最大化 / 恢复当前分屏 | `<leader>wm` |

JetBrains 的 Editor Split 与 Neovim Window 生命周期不同，因此这里只对齐创建、关闭和最大化操作。

## 安装与加载

需要安装以下 JetBrains 插件：

- [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim)
- [IdeaVim-EasyMotion](https://plugins.jetbrains.com/plugin/13360-ideavim-easymotion)
- [AceJump](https://plugins.jetbrains.com/plugin/7086-acejump)

IdeaVimExtension 不是这套快捷键的必要依赖。`surround` 和 `commentary` 由 IdeaVim 的可选 Vim 插件提供，通过 `.ideavimrc` 中的 `set` 启用。

修改配置后执行：

```vim
:source ~/.ideavimrc
```

检查选项、映射和 JetBrains Action ID：

```vim
:set
:map
:actionlist GotoFile
```

也可以启用 `set trackactionids`，通过执行 IDE 动作确认其 Action ID；该选项只用于排障，不写入日常配置。

## 与 Neovim 的边界

以下功能只做语义对应：

- Neo-tree → Project Tool Window
- fzf-lua → Go to File / Find in Files / Switcher
- Trouble → Problems Tool Window
- LazyGit / Gitsigns → VCS 菜单、Commit、文件历史和变更标记
- Neotest → JetBrains Run Context 与 Run Configuration
- LSP Code Action → JetBrains Intentions

以下 Neovim 能力不在 IdeaVim 中建立伪映射：Conjure、nvim-paredit、Snacks、Conform、nvim-lint、Tree-sitter textobjects、Lazy、Mason 和 Neovide 专属操作。

当快捷键没有反应时，依次确认插件已启用、执行 `:source ~/.ideavimrc`、用 `:map {key}` 检查映射，再用 `:actionlist {pattern}` 检查当前 IDE 是否提供对应动作。
