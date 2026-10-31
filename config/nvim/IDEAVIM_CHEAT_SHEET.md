# IdeaVim / Neovim 共用快捷键

Leader 是空格；未标模式的按键在 Normal 编辑器中使用。配置入口：[IdeaVim](../../symlink/ideavimrc.symlink)、[Neovim 手册](./NEOVIM_CHEAT_SHEET.md)。

同键对应同一任务。IDE 文件标签对应 Buffer，Problems 对应诊断；需要选择范围或点击原生按钮的步骤列在表里，不能省略。

## 文件与导航

| 任务 | 按键 | IdeaVim 操作及范围 |
| --- | --- | --- |
| 保存并回 Normal | `Ctrl-s` | 当前文件；Normal / Visual / Insert |
| 退出并清搜索高亮 | `Esc` | Normal / Visual / Insert |
| 查文件 | `空格 空格` / `<leader>ff` | Go to File；检查弹窗 Scope |
| 已打开文件列表 | `<leader>,` / `<leader>fb` | Switcher，选择文件项；其中也有工具窗口 |
| 最近文件 | `<leader>fr` | 包括已关闭的文件 |
| 前／后文件 | `H/L`、`[b` / `]b` | IDE 当前标签组；Neovim 是已列出的 Buffer |
| 两个文件来回切换 | `<leader>bb` / 空格后反引号 | `<C-^>` alternate file |
| 关闭文件／其他文件 | `<leader>bd` / `<leader>bo` | IDE 当前标签／标签组；Neovim 对应 Buffer |
| 新建文件 | `<leader>fn` | IDE 选择目录和名称；Neovim 先建无名 Buffer |
| 在左侧树定位当前文件 | `<leader>e` / `<leader>fe` / `<leader>gp` | 两端均打开、聚焦树并选中当前文件；重复按不关树 |
| 复制相对路径 | `<leader>fy` | 在菜单选择 **Path From Repository Root**；非 Git 项目选择 **Path From Content Root**。Neovim 自动选择 Git 根／项目根 |
| 定义／引用／实现／类型 | `gd` / `gr` / `gI` / `gy` | IDE 对应代码导航动作 |
| 回跳／前进 | `Ctrl-t` 或 `Ctrl-o` / `Ctrl-i` | IDE Back / Forward；Neovim jump list |
| 当前文件上／下一个符号使用处 | `[[` / `]]` | IDE Under Caret Usage；需 IDE 能识别该符号 |
| 文档／参数 | `K` / `gK` | Insert 参数信息用 `Ctrl-k` |

```text
A ── gd / gI / gy ──→ B
A ←─ Ctrl-t / Ctrl-o ─ B
A ───── Ctrl-i ─────→ B
```

Normal `Ctrl-t` 两边均回到上次跳转位置；不再使用 tag stack。Insert `Ctrl-t` 保留缩进。IDE 历史与 Neovim jump list 记录条件不同，IDE 不支持用 `:jumps` 管理这些动作；`Ctrl-i` 与 Tab 的区分受终端／IDE 键盘事件影响。

`fy` 使用显式菜单，避免在非 Git 文件上调用不可用 Action 后留下旧剪贴板。多模块非 Git 项目的 IDE content root 与 Neovim 项目根可能不同，复制时确认根目录。`gf` 保留 Vim 原生文件跳转，引用使用 `gr`。

## 文件树与结果列表

IDE 使用内置 `NERDTree` / `NERDTreeEverywhere` 扩展，无须另装 NERDTree。以下字母键只在树获得焦点时使用。

| 操作 | 共用按键 | 补充 |
| --- | --- | --- |
| 上／下移动 | `k/j` | 不自动打开经过的文件 |
| 打开文件／展开或收起目录 | `l` / `Enter` | `Enter` 在 IDE 保留原生行为 |
| 回父目录并折叠 | `h` | Neovim 已调整为与 IdeaVim NERDTree 一致 |
| 首／末项 | `gg/G` | IDE 不支持 NERDTree 计数移动 |
| 新建文件／目录 | `a/A` | 填名称并确认 |
| 删除／重命名 | `d/r` | IDE 使用原生确认或重构流程 |
| 复制／粘贴 | `c/p` | 文件树内操作文件 |
| 剪切 | `Cmd-x` | Neovide 或能传递该键的终端；Neovim 另保留 `x` |
| 水平／垂直分屏打开 | `s/v` | 当前选中文件 |
| 刷新 | `gr` | IDE 原 `r` 已让给重命名 |
| 关闭树 | `q` | 返回编辑 |

| 面板 | 操作规则 |
| --- | --- |
| IDE Project 树 | 关闭工具栏的 **Open Files with Single Click / Autoscroll to Source**，避免 `j/k` 经过文件时打开它；`e/fe/gp` 负责显式定位 |
| Find Usages / Problems 等树形结果 | NERDTreeEverywhere 提供 `j/k`、`h`、`l` 等导航；不保证具有文件创建／剪贴板动作 |
| 文件搜索、Switcher 等普通列表 | 两边用方向键、`Enter`、`Esc`；输入框里的字母正常搜索 |
| 树内搜索 | IDEA 用 `/` 进入 Speed Search；Neo-tree 用其过滤功能。退出搜索后再用字母导航 |

预览入口 `P` 均可用，但 Neovim 是浮动预览，IDE 是打开文件并保留树焦点。IDE `I` 切换 excluded files，Neovim `H` 切换隐藏文件，过滤对象不同，未合并。

## 编辑、搜索与分屏

| 任务 | 按键 | 模式／说明 |
| --- | --- | --- |
| 按显示行上下移动 | `j/k` | Normal / Visual；带计数如 `3j` 则按实际行 |
| 正／反向搜索下一项 | `n/N` | 与最后使用 `/` 或 `?` 无关；Normal 会展开折叠 |
| 连续调整缩进 | `<` / `>` | Visual 后保留选区 |
| 快速跳转 | `s` | EasyMotion／Flash；搜索标签交互略有不同 |
| 注释 | `gcc` / `gc{motion}` | Visual 用 `gc` |
| 包裹／删除／替换包裹 | `ys` / `ds` / `cs` | 例：`ysiw"`、`ds"`；Visual 用 `S{char}` |
| 上／下移行 | `Alt-k/j` | Normal / Visual / Insert；macOS 需将 Option 键交给编辑器 |
| 项目搜索 | `<leader>/` / `<leader>sg` | Normal / Visual；IDE 确认 Scope |
| 搜索单词／选区 | `<leader>sw` | Normal / Visual |
| 搜索替换 | `<leader>sr` | Normal / Visual |
| 文件／项目符号 | `<leader>ss` / `<leader>sS` | File Structure / Go to Symbol |
| 查动作／快捷键 | `<leader>sC` / `<leader>sk` | IDE Find Action；自定义 Vim 映射用 `:map` |
| Code Action／重命名 | `<leader>ca` / `<leader>cr` | `ca` 支持 Visual |
| 格式化／整理导入 | `<leader>cf` / `<leader>co` | `cf` 支持 Visual；具体结果由格式化器决定 |
| 切换软换行 | `<leader>uw` | 编辑器 |
| 切换分屏 | `Ctrl-h/j/k/l` | IDEA 仅编辑器分屏 |
| 水平／垂直分屏 | `<leader>-` / `<leader>\|` | 编辑器 |
| 收起当前分屏，保留文件 | `<leader>wd` | IDE **Unsplit** 合并标签；Neovim 关窗口、保留 Buffer |
| 最大化／恢复分屏 | `<leader>wm` | 编辑器 |
| 终端 | `<leader>ft` / `Ctrl-/` / `Ctrl-_` | IDE 激活 Terminal；Neovim 浮动终端。IDE 不强制切换 cwd |

不要用 IdeaVim 原生 `Ctrl-w c` 代替 `wd`：它会关闭当前分屏内的全部标签。关闭最后一个文件 `bd` 仍可能同时关闭该分屏。

### Neovim 浮动终端

`<leader>` 是空格；以下终端内操作仅适用于 Neovim。

| 任务 | 按键／命令 | 说明 |
| --- | --- | --- |
| 打开／隐藏终端 | `Ctrl-/`（兼容 `Ctrl-_`） | 项目根目录；隐藏保留进程 |
| 打开项目根目录终端 | `空格 → f → t` | Normal 模式 |
| 打开当前工作目录终端 | `空格 → f → Shift+t` | Normal 模式，即 `<leader>fT` |
| 退出终端输入模式 | `Esc` | 进入 Normal；不结束 shell |
| 移动光标 | `h/j/k/l` 或方向键 | 先按 `Esc` |
| 选择文本／整行 | `v` / `V`，再移动光标 | 先按 `Esc` |
| 复制选区 | `y` | Visual 模式 |
| 复制到系统剪贴板 | `"+y` | Visual 模式 |
| 恢复终端输入 | `i` | Normal 模式 |
| 结束 shell | 输入 `exit` 回车，或空命令行按 `Ctrl-D` | 终端输入模式；结束当前 shell |

选择并复制的流程：`Esc` → `v` → 移动选中 → `"+y` → `Ctrl-/` 隐藏终端。

## 文本跳转、选区与插件

| 任务 | 共用按键 | 实际范围／边界 |
| --- | --- | --- |
| 行内字符跳转 | `f/F/t/T`、`;`、`,` | 两边均为原生 Vim 当前行范围；Neovim 已关闭 Flash char 增强 |
| 快速标签跳转 | `s` | 同任务；EasyMotion / Flash 标签交互不同 |
| 开始／扩展选区 | Normal `S`、Normal / Visual `Ctrl-Space` | IDE Extend Selection；Neovim 当前 Treesitter 节点向父节点扩展，无标签选择步骤 |
| 缩小选区 | Visual `Backspace` | IDE Shrink Selection；Neovim 回退本次扩展历史 |
| 修改整行 | `cc` | Normal `S` 已用于选区，不再执行 substitute |
| 包裹选区 | Visual `S{char}` | 保留 surround，与 Normal `S` 分工 |
| 前／后函数起点 | `[f` / `]f` | Normal / Visual / Operator；IdeaVim `[m/]m`，依赖语言 PSI |
| 前／后函数终点 | `[F` / `]F` | 对应 `[M/]M` |
| 参数内／外对象 | `ia/aa` | 如 `cia`、`daa`；已启用 argtextobj，识别圆／方／花括号 |
| 函数外部对象 | `af` | 对应函数／方法定义，不含前置文档；如 `vaf`、`yaf` |
| 函数内部对象 | `if` | 对应内置 `im`；仅在扩展能识别函数 body 时可用。当前源码未覆盖所有 Python / Rust body 类型，不能保证这些语言可用 |
| 整个类对象 | `ac` | 定义及类体；没有类内部 `ic` 的伪映射 |
| 任意引号／括号对象 | `iq/aq`、`ib/ab` | 已启用 mini-ai；不再把 `ib` 仅理解为圆括号 |
| 整个文件／去首尾空白 | `ag/ig` | 已启用 textobj-entire，并重绑默认 ae/ie，避免与 Neovim 子单词对象冲突 |
| 注释行／motion／选区 | `gcc`、`gc{motion}`、Visual `gc` | 两边已有 |
| 在下方／上方新增注释行 | `gco/gcO` | 与 LazyVim 同一编辑序列，最后进入 Insert |
| 补全确认／正常换行 | Insert `Tab` / `Enter` | IDE 需执行设置脚本并重新打开；Neovim 已配置 |

IDE 的结构选区由 PSI 决定，Neovim 由 Treesitter 决定，节点边界不保证逐字相同。Neovim 无 parser 时只选择当前单词；IDE 原生 Extend Selection 通常还可继续扩展。mini-ai 的引号转义、嵌套搜索、计数和跨行范围也有实现差异，复杂文本优先用明确的 `i"/i)/i]` 对象。`ig` 两边对首尾行空格的裁剪不同。

| Surround | 对齐范围 |
| --- | --- |
| `ys/yss/ds/cs`、Visual `S` | 基础操作共用；如 `ysiw"`、`yss)`、`ds"`、`cs"'` |
| `(` / `)` 等括号字符 | 开括号添加内部空格，闭括号紧贴文本；修改时空白裁剪可能不同 |
| `ys{motion}t` / `ys{motion}f` | 两边支持标签／函数调用包裹；输入提示不同 |
| `<` / `s` 等特殊包裹字符 | 两个实现解释不同，未列为共用操作 |
| `ys{motion}i`、`yS/ySS`、Insert `Ctrl-g s/S` | Neovim 专属，IDE 内置 surround 无这些入口 |

| Neovim 专属操作 | 独立入口／范围 |
| --- | --- |
| Flash Treesitter 标签选择 | `<leader>jS`，Normal / Visual / Operator |
| Flash 远程操作 | `<leader>jr`，Operator |
| Flash Treesitter 搜索 | `<leader>jR`，Operator / Visual |
| 类／参数起点与终点跳转 | `[c/]c/[C/]C`、`[a/]a/[A/]A`；IDE 未绑定成其他对象 |
| 更丰富的文本对象 | `ic`、`io/ao`、`id/ad`、`ie/ae`、`iu/au`、`in/an/il/al` 等；IDE 未配置等价能力 |

Operator `S/r/R` 不再调用 Flash；Visual `R` 也已恢复原生行为。插件专属动作有明确入口，不与共用 Vim 操作混用。

## 诊断

| 任务 | 按键 | IDE 额外步骤／范围 |
| --- | --- | --- |
| 光标处诊断详情 | `<leader>cd` | Show Error Description |
| 上／下一个诊断 | `[d` / `]d` | 当前文件，需将 Next Error 设置为 **All Problems**，包含 warning / error |
| 已检测的问题集合 | `<leader>xx` / `<leader>sd` | 打开 Problems，选择所需集合页签／Scope；不会自动切换页签 |
| 当前文件诊断 | `<leader>xX` / `<leader>sD` | 打开 Problems 后选择 **File** 页签 |
| 上／下一个结果 | `[q` / `]q` | IDE Previous / Next Occurrence，作用于当前可用的结果导航器；Neovim Quickfix／Trouble |
| 只看 error 或 warning | 无统一直接跳转键 | IDE 在 Problems 中选择 severity filter；Neovim 另有 `[e/]e`、`[w/]w` |

“全部诊断”指分析器已经提供的问题集合，不能保证未打开文件都已分析。IDE 的 Project Errors 能力依赖语言／插件；Neovim 依赖已有 LSP。没有额外安装 Java LSP。`xX/sD` 的 File 页签选择是必要步骤，不能把打开 Problems 本身称为已过滤当前文件。

## Git：使用真实暂存区

先启用 IDE **Settings → Version Control → Git → Enable staging area**。部分变更暂存必须在 gutter popup／diff 中操作，不能拿整个文件的 Stage 或 changelist 勾选代替。

| 任务 | 按键 | IdeaVim | Neovim |
| --- | --- | --- | --- |
| Git 操作入口 | `<leader>gg` | VCS Quick List | Lazygit |
| 变更状态 | `<leader>gs` | Git staging 面板 | Git status 文件列表 |
| 提交历史 | `<leader>gl` / `<leader>gc` | Git Log | Git commits；`gc` 不提交 |
| 选择变更文件看 diff | `<leader>gd` | Local Changes，再选文件 diff | Git diff 文件列表 |
| 文件历史 | `<leader>gf` | File History | 文件历史 |
| 当前行／选区历史 | `<leader>gb` | Normal 先选当前行；Visual 保留选区 | Lazygit 行范围历史 |
| 文件相对 HEAD 的 diff | `<leader>ghd` | Compare with Repository Version | Gitsigns diffthis HEAD |
| 上／下变更块 | `[h` / `]h` | VCS change marker | Gitsigns hunk |
| 预览当前变更块 | `<leader>ghp` | 打开 gutter popup | 行内预览 |
| 暂存当前块 | `<leader>ghs` | 光标放在变更块，弹窗中点 **Stage** | 直接暂存未暂存块；不会反向取消暂存 |
| 取消所选块的暂存 | `<leader>ghu` | staging 面板选 **Staged** 文件，在 staged diff 中选块并 **Unstage** | Lazygit 选文件，进入 staged diff，选择块并 Unstage；按界面键位提示操作 |
| 暂存当前文件全部变更 | `<leader>ghS` | Git.Stage.Add，编辑器当前文件 | Gitsigns stage_buffer |
| 丢弃当前块／选区修改 | `<leader>ghr` | Rollback Changed Lines；Normal / Visual | reset_hunk；Normal / Visual |
| 当前行／文件 blame | `<leader>ghb` / `<leader>ghB` | Annotate 后看目标行 | 行详情／整文件 blame |

`ghu` 不再撤销“本次会话最后一次 stage”，可以选择任意已暂存块。同一位置同时有 staged 与 unstaged 修改时，进入 **staged diff** 后操作。不要在文件列表里执行整文件 Unstage 来代替块级操作。

Neovim Visual `ghs` 可暂存选区；IDE 的行级暂存通过 diff 选行后 Stage，未给 Visual `ghs` 伪绑定整块操作。`ghr` 会丢弃修改。IDE 部分动作仅对已纳入 Git 的文件可用；新文件在 `gs` 面板选择 Add/Stage。

## 测试

| 任务 | 按键 | IDE 额外步骤 |
| --- | --- | --- |
| 运行光标上下文 | `<leader>tr` | Run Context，可能是测试／类／程序；核对运行范围 |
| 当前文件测试 | `<leader>tt` | Run Configuration 选择器中选当前文件配置 |
| 全部测试 | `<leader>tT` | 同一选择器中选预先建立的全套测试配置 |
| 重跑／停止 | `<leader>tl` / `<leader>tS` | 当前运行会话 |
| 结果树／输出／输出面板 | `<leader>ts` / `<leader>to` / `<leader>tO` | 共用 Run 窗口，再选测试树或 Console |
| Watch | Neovim `<leader>tw` | IDE 在支持的运行器中打开 Auto Test；没有跨运行器统一映射 |

## 安装、设置与加载

| 项目 | 操作 |
| --- | --- |
| 插件 | 安装 IdeaVim、IdeaVim-EasyMotion、AceJump；surround、commentary、mini-ai、argtextobj、functextobj、classtextobj、textobj-entire、NERDTree 为 IdeaVim 内置扩展 |
| 生效文件 | `~/.ideavimrc` 链接到 `symlink/ideavimrc.symlink`；仓库根目录旧 `.ideavimrc` 不加载 |
| IDE 设置 | 退出 IDEA / PyCharm 后，在仓库运行 `python3 scripts/jetbrains-align.py` |
| 脚本范围 | 为已安装的 IntelliJIdea / PyCharm 配置启用真实 staging，关闭诊断 errors-first，并将补全确认改为 Tab、移除 Enter 确认；保留其他选项，原文件旁生成带时间的 `.bak` |
| 正在运行的 IDE | 脚本输出 PENDING 并跳过，退出后重跑；不会自动关闭 IDE |
| Keymap | 保留现有 `macOS copy` 的其他键位；Tab 使用普通补全接受，不替换标识符后缀。没有添加全局单字母快捷键 |
| 项目树 | 每个项目关闭 Open Files with Single Click / Autoscroll to Source；这是项目级 UI 设置，脚本不修改项目 workspace.xml |
| 重载 | `:source ~/.ideavimrc`；首次启用树扩展或修改 `NERDTreeMap*` 后重启 IDE，扩展会缓存树按键 |
| Neovim | 重启以重新执行插件 on_attach；不只 source 单个 Lua 文件 |

手动设置诊断时，在编辑器右上问题指示器的设置中把 **'Next Error' Action (F2) Goes Through → All Problems** 打开。参考 [JetBrains 诊断说明](https://www.jetbrains.com/help/idea/file-and-project-wide-analysis.html)、[Git staging 说明](https://www.jetbrains.com/help/idea/commit-and-push-changes.html)、[IdeaVim NERDTree](https://github.com/JetBrains/ideavim/wiki/NERDTree-support)。

排查：`:nmap <leader>ghs`、`:nmap <C-t>`、`:xmap <leader>ghr`、`:actionlist Git.Show.Stage`。动作存在不代表当前上下文可用。需要时临时 `:set trackactionids`；检查后 `:set notrackactionids`。

## 验收与剩余差异

| 场景 | 验收标准 |
| --- | --- |
| 3 个文件、2 个分屏 | `bb/H/L/fb` 找到目标文件；`wd` 收起分屏后文件仍可从列表找到 |
| 文件定位 | 从搜索结果打开文件，再按 `e/fe/gp`，左侧选中该文件 |
| warning 在 error 前 | `]d` 按位置经过两者；`xX/sD` 选 File 后只显示当前文件 |
| 2 个不相邻 Git 块 | `ghs` 后 `git diff --cached` 只含目标块；`ghS` 才包含整文件 |
| 同处已暂存和未暂存修改 | `ghu` 在 staged diff 撤销指定块，保留 working tree 的后续修改 |
| 搜索输入 | 输入含 `j/k/a/r` 的文件名，字母不被树快捷键截走 |
| 重载 | 冷启动及 `:source` 均无解析错误，`gf` 不残留旧引用映射 |

IDE Action ID、扩展源码与设置存储字段已按本机安装包核对。本次辅助功能访问已允许，但 IDEA 没有向自动化提供可操作的项目窗口；日志确认收到临时项目打开请求。以上 IDE 交互用例仍需人工验收，不能把静态核对当成实机通过。

| 本次验证（2026-09-30） | 结果 |
| --- | --- |
| 实际 Neovim + 临时 Git 仓库 | 已验证块级／整文件暂存、混合 staged/unstaged 修改、重复 `ghs` 不反向取消暂存 |
| 实际 Neovim 文件操作 | 已验证 3 个文件在关闭分屏后保留、仓库相对路径、三个定位入口、`h` 返回并折叠父目录 |
| 实际 Neovim 文本输入 | 已验证非破坏性 S、扩展／回退选区、基础 surround、f 重复不跨行、参数／引号／括号／函数对象、函数跳转、gco/gcO |
| 实际 Neovim 补全输入 | Tab 接受候选，Enter 接受已选候选；配置见 [completion.lua](./lua/plugins/completion.lua) |
| IdeaVim 静态核对 | 两款 IDE 的 Action ID、新增扩展名称、Plug 入口均已按安装包核对；用替代 Action 的 Neovim 检查通过映射语法及重复 source，不等于 IdeaVim 实机验收 |
| IDE 设置落盘 | PyCharm 的设置及 Tab 补全 Keymap 已写入；IDEA 运行中被跳过，退出后执行上述脚本 |
| 尚未完成的交互验收 | IDE 面板／分屏／诊断／块级 Stage 和 Unstage，以及 Lazygit 内选块 Unstage；后者仅验证入口不误改 index |

| 保留的差异 | 使用方式 |
| --- | --- |
| 多分屏文件列表／关闭范围 | IDE 标签组与 Neovim 全局 Buffer 范围不同；操作前确认组 |
| IDE 页签／运行范围 | Problems、测试配置、Git staged diff 需上表列出的额外选择 |
| cwd／项目根双套搜索 | Neovim 保留 `fF/sG/fT`；IDE 在原生面板选 Scope／目录 |
| IDE 分析与 LSP | 诊断和格式化结果由各自分析器决定，不保证内容逐条相同 |
| 专属能力 | Neovim 的不可见 Buffer 清理 `bi`、Flash 特殊模式、Treesitter 对象、插件/LSP 管理等保留；IDE 使用自身功能 |
