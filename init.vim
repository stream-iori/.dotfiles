call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
" markdown start
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" markdown end
Plug 'ctrlpvim/ctrlp.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'tomasr/molokai'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'majutsushi/tagbar'                  "标签列表
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'fannheyward/rainbow_parentheses.vim' "括号匹配高亮
Plug 'tpope/vim-surround'                 "快速加环绕符
Plug 'vim-scripts/SuperTab'               "Tab代码提示
Plug 'Raimondi/delimitMate'               "自动括号补全
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "自动补全
" syntax highlight
Plug 'pearofducks/ansible-vim'
Plug 'tbastos/vim-lua'
Plug 'chr4/nginx.vim'
Plug 'robbles/logstash.vim'
Plug 'cespare/vim-toml'
call plug#end()
let g:mapleader=' ' 
" 对接系统剪切板
set clipboard+=unnamedplus
set autowrite
set laststatus=2
set background=dark
colorscheme Molokai "NeoSolarized

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

set rtp+=/usr/local/opt/fzf


" 设置:E command 为Explore防止歧义
cabbrev E Explore
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:deoplete#enable_at_startup = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:instant_markdown_slow = 1
let g:instant_markdown_open_to_the_world = 1
" enable LaTeX
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" syntastic checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" lua
let g:syntastic_lua_checkers = ["luac", "luacheck"]
"let g:syntastic_lua_luacheck_args = "--std ngx_lua"

map <leader>t :NERDTreeToggle<CR>
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Ignpre some
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" show bookmark
let NERDTreeShowBookmarks=1
" git 
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
  \ }

" ansible
let g:ansible_name_highlight = 'd'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }

" Use ag indead of ack.vim
let g:ackprg = 'ag --vimgrep'
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>h :History<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>A :Ag<CR>

noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

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

" Buffer
" Move to the previous buffer 
nnoremap <Leader>bp :bp<CR>

" Move to the next buffer
nnoremap <Leader>bn :bn<CR>

" List all possible buffers 
nnoremap <Leader>bl :ls<CR>

" List all possible buffers and accept a new buffer argument [1]
nnoremap <Leader>bb :ls<CR>:b

" insert mode 下控制方向
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-d> <Delete>

let g:UltiSnipsExpandTrigger="<M-Tab>"
" Golang
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
"autocmd FileType go nmap <C-[> <Plug>(go-def-pop)
" :GoDef but opens in a vertical split
autocmd FileType go nmap <C-]>v <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
autocmd FileType go nmap <C-]>s <Plug>(go-def-split)


let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_build_constraints = 1

let g:go_metalinter_enabled = ['golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['golint']
let g:go_metalinter_deadline = "5s"

let g:go_def_mode = 'godef'
let g:go_decls_includes = "func,type"

let g:go_auto_type_info = 1
set updatetime=100

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
nmap <M-2> :TagbarToggle<CR>

nnoremap <M-n> :cnext<CR>
nnoremap <M-p> :cprevious<CR>
nnoremap <M-c> :cclose<CR>

