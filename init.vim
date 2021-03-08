call plug#begin('~/.config/nvim/plugged')
" highlight
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" jump in file
Plug 'easymotion/vim-easymotion'
" grammar check
Plug 'w0rp/ale'
" markdown start
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'ferrine/md-img-paste.vim'
" markdown end
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' } "search

Plug 'iCyMind/NeoSolarized'
Plug 'tomasr/molokai'
Plug 'majutsushi/tagbar'                   "标签列表,类似Jetbrian structure

Plug 'fannheyward/rainbow_parentheses.vim' "括号匹配高亮
Plug 'tpope/vim-surround'                  "快速加环绕符

Plug 'airblade/vim-gitgutter'

" snip
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'                "自动括号补全
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" syntax highlight
Plug 'pearofducks/ansible-vim'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
call plug#end()

let g:mapleader=' ' 
" 对接系统剪切板
set clipboard+=unnamedplus
set autowrite
set laststatus=2
set background=dark
colorscheme Molokai "NeoSolarized 
set nocompatible
syntax on
filetype plugin on
set tabstop=2
set expandtab "TAB 自动变成空格
set autoindent
set softtabstop=0
set shiftwidth=2
set incsearch "查找短语时显示部分匹配
set ignorecase " 查找时忽略字母大小写
set smartcase

" 设置:E command 为Explore防止歧义
cabbrev E Lexplore
let g:netrw_liststyle = 3 "netrw view as tree mode
let g:netrw_banner = 0
let g:netrw_browse_split = 0 "open files in a new horizontally split
" let g:netrw_winsize = 25

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:instant_markdown_slow = 1
let g:instant_markdown_open_to_the_world = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" syntastic checker ale settings
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1 
" python checker
let g:ale_fixers = {
\   'javascript': ['standard'],
\   'python': ['pylint']
\}

let g:vimwiki_list = [{'path': '~/iCloud/notes',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'index': 'Wiki'}]
let g:vimwiki_global_ext = 0

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'imgs'
let g:mdip_imgname = 'image'

let g:Lf_ShowDevIcons = 0
let g:Lf_WorkingDirectoryMode = 'a'
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
"显示所有函数
noremap <leader>fs :LeaderfFunction!<CR> 
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

"GitGutter
highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
let g:gitgutter_enable = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1
nmap <leader>g] <Plug>(GitGutterNextHunk)
nmap <leader>g[ <Plug>(GitGutterPrevHunk)

" Auto Completion
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ansible
let g:ansible_name_highlight = 'd'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }

noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C> :update<CR>
inoremap <silent> <C-S> <C-O> :update<CR>

" EasyMotion 
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <Leader>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" insert mode 下控制方向
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-d> <Delete>

let g:UltiSnipsExpandTrigger="<M-Tab>"
nnoremap <M-n> :cnext<CR>
nnoremap <M-p> :cprevious<CR>
nnoremap <M-c> :cclose<CR>
