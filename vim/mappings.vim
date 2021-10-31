""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Mappings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

noremap H ^
noremap L $
nnoremap J G
nnoremap K gg

vnoremap J G
vnoremap K gg

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <Leader>/ :nohl<Cr>

if has('nvim')
  noremap <C-h> <C-\><C-n><C-w>h
  noremap <C-j> <C-\><C-n><C-w>j
  noremap <C-k> <C-\><C-n><C-w>k
  noremap <C-l> <C-\><C-n><C-w>l
  noremap <C-c> <C-\><C-n>:q<Cr>
endif

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <silent> <Leader>sv :source $MYVIMRC<Cr>

nnoremap gen :cnext<CR>
nnoremap gep :cprevious<CR>

