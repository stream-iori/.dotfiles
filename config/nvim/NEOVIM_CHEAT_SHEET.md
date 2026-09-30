# Neovim / LazyVim 速查手册

本文档对应当前配置。Leader 为 `<Space>`，LocalLeader 使用 Neovim 默认的 `\`。第一次使用请从 [Neovim 场景化新手指南](./NEOVIM_BEGINNER_GUIDE.md) 开始；进阶文本处理参见 [Neovim 技巧、Hack 与文本处理手册](./NEOVIM_TIPS_AND_HACKS.md)；JetBrains IDE 用户参见 [IdeaVim 速查手册](./IDEAVIM_CHEAT_SHEET.md)。

## 核心操作

| 功能 | 快捷键 |
| --- | --- |
| 查看当前 Buffer 快捷键 | `<leader>?` |
| 搜索所有快捷键 | `<leader>sk` |
| 保存文件 | `<C-s>` |
| 新建文件 | `<leader>fn` |
| 关闭 Buffer | `<leader>bd` |
| 上一个 / 下一个 Buffer | `<S-h>` / `<S-l>` |
| 最近两个 Buffer 间切换 | `<leader>bb` |
| 关闭其他 Buffer | `<leader>bo` |
| 删除不可见 Buffer | `<leader>bi` |
| 退出全部 | `<leader>qq` |
| 插件管理 | `<leader>l` |
| Mason 工具管理 | `<leader>cm` |
| 通知历史 | `<leader>n` |
| 清除通知 | `<leader>un` |
| 恢复当前目录会话 | `<leader>qs` |
| 恢复上次会话 | `<leader>ql` |

Neovide 额外支持 `<D-s>` 保存、Visual `<D-c>` 复制，以及各模式下的 `<D-v>` 系统剪贴板粘贴。终端版 Neovim 不覆盖 `<D-v>`。

## 文件、搜索与 Git

| 功能 | 快捷键 |
| --- | --- |
| 打开 Neo-tree 并定位当前文件（项目根目录） | `<leader>e` / `<leader>fe` / `<leader>gp` |
| 打开 Neo-tree（当前工作目录） | `<leader>E` / `<leader>fE` |
| 复制当前文件相对路径（Git 根优先，否则项目根） | `<leader>fy` |
| 查找项目文件 | `<leader><space>` / `<leader>ff` |
| 查找当前目录文件 | `<leader>fF` |
| Git 文件 | `<leader>fg` |
| 最近文件 | `<leader>fr` |
| 当前目录最近文件 | `<leader>fR` |
| 全局文本搜索 | `<leader>sg` |
| 当前目录文本搜索 | `<leader>sG` |
| 搜索光标下单词 | `<leader>sw` |
| 搜索当前 / 工作区符号 | `<leader>ss` / `<leader>sS` |
| 搜索命令 | `<leader>sC` |
| 恢复上一次搜索 | `<leader>sR` |
| 项目内搜索替换 | `<leader>sr` |
| 切换 Buffer | `<leader>,` / `<leader>fb` |
| Lazygit（项目根目录） | `<leader>gg` |
| Git 状态 | `<leader>gs` |
| Git 文件历史 | `<leader>gf` |
| 上一个 / 下一个 Git hunk | `[h` / `]h` |
| 行内预览 Git hunk | `<leader>ghp` |
| 暂存当前未暂存块／选区（不会反向取消暂存） | `<leader>ghs` |
| 选择已暂存块并取消暂存（进入 Lazygit） | `<leader>ghu` |
| 暂存当前文件 | `<leader>ghS` |
| 文件相对 HEAD 的 diff | `<leader>ghd` |
| 提交历史／变更文件 diff | `<leader>gl` 或 `<leader>gc` / `<leader>gd` |
| 当前行 Git blame | `<leader>ghb` |
| Reset Git hunk（丢弃修改） | `<leader>ghr` |

Neo-tree 内常用操作：

| 功能 | 快捷键 |
| --- | --- |
| 新建文件／目录 | `a/A` |
| 删除 | `d` |
| 重命名 | `r` |
| 复制 / 剪切 / 粘贴 | `c` / `Cmd-x`（也保留 `x`）/ `p` |
| 水平 / 垂直分屏打开 | `s` / `v` |
| 浮动预览 | `P` |
| 打开文件、展开／收起目录 | `l` / `Enter` |
| 回父目录并折叠（与 IdeaVim 一致） | `h` |
| 刷新／关闭树 | `gr` / `q` |
| 显示隐藏文件 | `H` |

`e/fe/gp` 都是显式定位：重复按保持文件树打开并选中当前文件。`Cmd-x` 需要 Neovide 或能传递该按键的终端。普通搜索列表共用方向键、Enter、Esc。

`ghu` 打开 Lazygit 后，选择文件并进入 **staged diff**，按界面提示选择目标块并 Unstage；不要在文件列表执行整文件 Unstage 来代替。它不再调用只撤销本次会话最后一次 stage 的 `undo_stage_hunk`。同一处存在 staged 和 unstaged 修改时，也明确操作 staged diff。

## 窗口与终端

| 功能 | 快捷键 |
| --- | --- |
| 浮动终端 | `<C-/>` |
| 终端进入 Normal 模式 | `<Esc>` |
| 窗口跳转 | `<C-h/j/k/l>` |
| 调整窗口高度 | `<C-Up>` / `<C-Down>` |
| 调整窗口宽度 | `<C-Left>` / `<C-Right>` |
| 水平分屏 | `<leader>-` |
| 垂直分屏 | `<leader>\|` |
| 关闭窗口 | `<leader>wd` |
| 最大化 / 恢复窗口 | `<leader>wm` |

## LSP、诊断与格式化

| 功能 | 快捷键 |
| --- | --- |
| 跳转定义 | `gd` |
| 导航回跳／前进 | `Ctrl-t` 或 `Ctrl-o` / `Ctrl-i` |
| 查找引用 | `gr` |
| 跳转实现 | `gI` |
| 跳转类型定义 | `gy` |
| 跳转声明 | `gD` |
| 查看文档 | `K` |
| 查看函数签名 | `gK` / Insert `<C-k>` |
| LSP 状态 | `<leader>cl` |
| 重命名符号 | `<leader>cr` |
| Code Action | `<leader>ca` |
| Source Action | `<leader>cA` |
| 整理导入 | `<leader>co` |
| 当前行诊断 | `<leader>cd` |
| 上一个 / 下一个诊断 | `[d` / `]d` |
| 上一个 / 下一个引用 | `[[` / `]]` |
| 已检测的全部诊断／搜索 | `<leader>xx` / `<leader>sd` |
| 当前文件诊断／搜索 | `<leader>xX` / `<leader>sD` |
| 上一个 / 下一个 Quickfix 项 | `[q` / `]q` |
| 格式化 | `<leader>cf` |
| 格式化嵌入语言 | `<leader>cF` |
| C/C++ 头文件与源文件切换 | `<leader>ch` |
| Rust Code Action | `<leader>cR` |
| Python 虚拟环境 | `<leader>cv` |

代码补全（Insert 模式）：

| 功能 | 快捷键 |
| --- | --- |
| 手动打开补全 / 查看文档 | `<C-Space>` |
| 下一个 / 上一个候选 | `<C-n>` / `<C-p>` |
| 确认选中候选（未选中时选首项） | `<Tab>` |
| 正常换行，不确认候选 | `<CR>` |
| 选择并接受第一个候选 | `<C-y>` |
| 关闭补全菜单 | `<C-e>` |
| 下一个 / 上一个代码片段位置 | 无补全候选时 `<Tab>` / `<S-Tab>` |

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
| Normal / Visual / Operator | `<leader>jS` | Flash Treesitter 跳转（Neovim 专属） |
| Operator | `<leader>jr` | Remote Flash（Neovim 专属） |
| Operator / Visual | `<leader>jR` | Treesitter Search（Neovim 专属） |

文本内操作与 IdeaVim 共用：

| 任务 | 按键 | 说明 |
| --- | --- | --- |
| 当前行找字符／重复／反向重复 | `f/F/t/T`、`;`、`,` | 关闭 Flash char 增强，保持当前行范围 |
| 开始／扩展结构选区 | Normal `S`、Normal / Visual `Ctrl-Space` | 从当前语法节点扩展到父节点，不弹标签；整行修改用 `cc` |
| 缩小选区 | Visual `Backspace` | 沿本次扩展历史回退；最小选区再按一次退出 |
| 无 parser 的普通文本 | Normal `S` / `Ctrl-Space` | 选择当前单词；后续语法扩展需 parser |
| 函数起点／终点跳转 | `[f/]f`、`[F/]F` | Normal / Visual / Operator；IDE 使用 PSI，Neovim 使用 Treesitter |
| 参数内／外对象 | `ia/aa` | 例如 `cia`、`daa` |
| 函数内／外对象 | `if/af` | 例如 `vaf`、`yaf`；IDE 的内部对象依赖语言支持 |
| 整个类对象 | `ac` | 例如 `vac`；IDE 没有共用 `ic` |
| 任意引号／括号对象 | `iq/aq`、`ib/ab` | 两边都启用 mini.ai 风格；嵌套、转义和计数仍有差别 |
| 整个文件／去首尾空白 | `ag/ig` | IDE 还会裁掉首尾行的空格，Neovim 默认仅跳过空白行 |
| 新增注释行 | `gco/gcO` | 下方／上方，最后进入 Insert |

`S` 按模式区分：Normal 扩展选区，Visual surround，Operator 不再调用 Flash。`r/R` 的 Flash 覆盖已移除；高级 Flash 功能见上面的独立入口。类内部 `ic`、代码块 `io/ao`、`in/an/il/al` 等仍是 Neovim 专属，不能在 IdeaVim 中照搬。

nvim-surround：

| 功能 | 快捷键 | 示例 |
| --- | --- | --- |
| 包裹 motion | `ys{motion}{char}` | `ysiw"` |
| 包裹整行 | `yss{char}` | `yss)` |
| 删除包裹 | `ds{char}` | `ds"` |
| 修改包裹 | `cs{old}{new}` | `cs"'` |
| 包裹 Visual 选区 | `S{char}` | Visual 选择后按 `S}` |
| 自定义左右分隔符 | `ys{motion}i` | `ysiwi`，依次输入 `/*`、`*/` |
| HTML 标签包裹 | `ys{motion}t` | `ysiwt`，输入 `strong` 得到 `<strong>word</strong>` |
| 函数调用包裹 | `ys{motion}f` | `ysiwf`，输入 `foo` 得到 `foo(word)` |

`i` 后分别输入左、右分隔符并按回车，分隔符可以是多个字符；Visual 模式下使用 `Si`。这是 Neovim 专属；`yS/ySS` 分行包裹和 Insert `Ctrl-g s/S` 也未在 IdeaVim 对齐。共用包裹字符优先用引号、`()[]{}`、`t`、`f`；`<`、`s` 的特殊解释不同。

其他常用编辑：

| 功能 | 快捷键 |
| --- | --- |
| 注释行 | `gcc` |
| 注释选区 / motion | `gc` |
| 在下方 / 上方新增注释 | `gco` / `gcO` |
| 上下移动行或选区 | `<A-j>` / `<A-k>` |
| 在下方 / 上方插入空行 | `]<Space>` / `[<Space>` |
| 用系统程序打开路径或 URL | `gx` |
| 上一个 / 下一个 TODO | `[t` / `]t` |
| 扩展语法选区 | Normal `S` 或 Normal / Visual `<C-Space>` |
| 缩小语法选区／退出最小选区 | Visual `<BS>` |
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

Markdown 自动启用英文拼写检查、CJK 忽略、软换行和渲染。Markdown lint 忽略 MD013、MD025、MD033、MD041。

| 功能 | 快捷键 |
| --- | --- |
| Markdown 浏览器预览 | `<leader>cp` |
| 切换 Markdown 渲染 | `<leader>um` |
| 切换拼写检查 | `<leader>us` |
| 切换软换行 | `<leader>uw` |

常用命令：

- `:Lazy`：插件管理。
- `:Mason`：LSP、Formatter、Linter 工具管理。
- `:ConformInfo`：查看当前 Buffer 格式化器。
- `:LspInfo`：查看 LSP 状态。
- `:checkhealth`：运行健康检查。

## 与 IdeaVim 共用的操作约定

| 行为 | 约定 |
| --- | --- |
| `Ctrl-t` | Normal 回跳改用 jump list；Insert 保留原生缩进 |
| `j/k`、`n/N`、Visual `<`/`>` | 无计数按显示行；下一／上一匹配方向固定；缩进后保留选区 |
| `<leader>wd` | 关闭分屏并保留文件；IDE 用 Unsplit 合并标签 |
| `<leader>fy` | Neovim 自动复制仓库相对路径；IDE 在菜单选 Repository Root，非 Git 选 Content Root |
| Git／诊断／测试 | 同键进入同一任务；IDE 额外选择页签、配置或确认步骤见 [IdeaVim 手册](./IDEAVIM_CHEAT_SHEET.md) |

诊断仅覆盖分析器已上报的内容，不保证所有未打开文件都有结果。IDE 与 Neovim 的跨分屏文件范围仍有差异，详情和验收步骤见同一手册。
