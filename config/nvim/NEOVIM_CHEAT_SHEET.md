# Neovim / LazyVim 速查手册

本文档对应当前配置。Leader 为 `<Space>`，LocalLeader 使用 Neovim 默认的 `\`。第一次使用请从 [Neovim 场景化新手指南](./NEOVIM_BEGINNER_GUIDE.md) 开始；JetBrains IDE 用户参见 [IdeaVim 速查手册](./IDEAVIM_CHEAT_SHEET.md)。

## 核心操作

| 功能 | 快捷键 |
| --- | --- |
| 查看当前 Buffer 快捷键 | `<leader>?` |
| 搜索所有快捷键 | `<leader>sk` |
| 保存文件 | `<C-s>` |
| 新建文件 | `<leader>fn` |
| 关闭 Buffer | `<leader>bd` |
| 删除不可见 Buffer | `<leader>bi` |
| 退出全部 | `<leader>qq` |
| 插件管理 | `<leader>l` |
| Mason 工具管理 | `<leader>cm` |
| 通知历史 | `<leader>n` |
| 清除通知 | `<leader>un` |

Neovide 额外支持 `<D-s>` 保存、Visual `<D-c>` 复制，以及各模式下的 `<D-v>` 系统剪贴板粘贴。终端版 Neovim 不覆盖 `<D-v>`。

## 文件、搜索与 Git

| 功能 | 快捷键 |
| --- | --- |
| 打开 Neo-tree（项目根目录） | `<leader>e` / `<leader>fe` |
| 打开 Neo-tree（当前工作目录） | `<leader>E` / `<leader>fE` |
| 复制当前文件相对路径 | `<leader>fy` |
| 查找项目文件 | `<leader><space>` / `<leader>ff` |
| 查找当前目录文件 | `<leader>fF` |
| Git 文件 | `<leader>fg` |
| 最近文件 | `<leader>fr` |
| 当前目录最近文件 | `<leader>fR` |
| 全局文本搜索 | `<leader>sg` |
| 当前目录文本搜索 | `<leader>sG` |
| 搜索光标下单词 | `<leader>sw` |
| 切换 Buffer | `<leader>,` |
| Lazygit（项目根目录） | `<leader>gg` |
| Git 状态 | `<leader>gs` |
| Git 文件历史 | `<leader>gf` |

Neo-tree 内常用操作：

| 功能 | 快捷键 |
| --- | --- |
| 新建 | `a` |
| 删除 | `d` |
| 重命名 | `r` |
| 复制 / 剪切 / 粘贴 | `c` / `x` / `p` |
| 水平 / 垂直分屏打开 | `s` / `v` |
| 浮动预览 | `P` |
| 打开 / 关闭节点 | `l` / `h` |
| 显示隐藏文件 | `H` |

Neo-tree 已启用 `follow_current_file`，打开文件树时会跟踪当前文件，不需要额外 reveal 快捷键。

## 窗口与终端

| 功能 | 快捷键 |
| --- | --- |
| 浮动终端 | `<C-/>` |
| 窗口跳转 | `<C-h/j/k/l>` |
| 水平分屏 | `<leader>-` |
| 垂直分屏 | `<leader>\|` |
| 关闭窗口 | `<leader>wd` |
| 最大化 / 恢复窗口 | `<leader>wm` |

## LSP、诊断与格式化

| 功能 | 快捷键 |
| --- | --- |
| 跳转定义 | `gd` |
| 查找引用 | `gr` |
| 跳转实现 | `gI` |
| 跳转类型定义 | `gy` |
| 查看文档 | `K` |
| 重命名符号 | `<leader>cr` |
| Code Action | `<leader>ca` |
| Source Action | `<leader>cA` |
| 整理导入 | `<leader>co` |
| 当前行诊断 | `<leader>cd` |
| 全部诊断 | `<leader>xx` |
| Buffer 诊断 | `<leader>xX` |
| 格式化 | `<leader>cf` |
| 格式化嵌入语言 | `<leader>cF` |
| C/C++ 头文件与源文件切换 | `<leader>ch` |
| Rust Code Action | `<leader>cR` |
| Python 虚拟环境 | `<leader>cv` |

显式格式化工具：

| 语言 | Formatter |
| --- | --- |
| Lua | Stylua |
| Python | Ruff Format |
| C/C++/Objective-C/CUDA | clang-format |
| JavaScript/TypeScript/JSON/HTML/CSS | Prettier |
| Rust | rustfmt |
| Shell | shfmt |
| Markdown | Prettier + markdownlint-cli2 + markdown-toc |

诊断来源包括语言服务器、Ruff、Shellcheck 和 markdownlint-cli2。ESLint 只在项目存在 ESLint 配置时启动。

## 跳转、包裹与编辑

Flash：

| 模式 | 快捷键 | 功能 |
| --- | --- | --- |
| Normal / Visual / Operator | `s` | Flash 跳转 |
| Normal / Operator | `S` | Treesitter 跳转 |
| Operator | `r` | Remote Flash |
| Operator / Visual | `R` | Treesitter Search |

nvim-surround：

| 功能 | 快捷键 | 示例 |
| --- | --- | --- |
| 包裹 motion | `ys{motion}{char}` | `ysiw"` |
| 包裹整行 | `yss{char}` | `yss)` |
| 删除包裹 | `ds{char}` | `ds"` |
| 修改包裹 | `cs{old}{new}` | `cs"'` |
| 包裹 Visual 选区 | `S{char}` | Visual 选择后按 `S}` |

其他常用编辑：

| 功能 | 快捷键 |
| --- | --- |
| 注释行 | `gcc` |
| 注释选区 / motion | `gc` |
| 上下移动行或选区 | `<A-j>` / `<A-k>` |
| Treesitter 扩展选区 | `<C-Space>` |
| 添加拼写白名单 | `zg` |
| 标记拼写错误 | `zw` |

## 测试

| 功能 | 快捷键 |
| --- | --- |
| 运行当前文件 | `<leader>tt` |
| 运行全部测试文件 | `<leader>tT` |
| 运行最近测试 | `<leader>tr` |
| 重跑上一次 | `<leader>tl` |
| 测试摘要 | `<leader>ts` |
| 查看输出 | `<leader>to` |
| 输出面板 | `<leader>tO` |
| 停止测试 | `<leader>tS` |
| Watch 当前文件 | `<leader>tw` |

已配置 Python、Jest、Vitest 和 Rust Neotest Adapter。当前配置不包含 DAP 调试功能。

## Markdown 与常用命令

Markdown 自动启用英文拼写检查、CJK 忽略、软换行和渲染；预览命令为 `<leader>cp`。Markdown lint 忽略 MD013、MD025、MD033、MD041。

常用命令：

- `:Lazy`：插件管理。
- `:Mason`：LSP、Formatter、Linter 工具管理。
- `:ConformInfo`：查看当前 Buffer 格式化器。
- `:LspInfo`：查看 LSP 状态。
- `:checkhealth`：运行健康检查。
