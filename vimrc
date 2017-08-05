let mapleader = ","
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Vundles
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-rails.git'
Plugin 'anyakichi/vim-autoclose'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'FuzzyFinder'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-endwise'
Plugin 'L9'
Plugin 'vim-scripts/ScrollColors'
Plugin 'mileszs/ack.vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nikvdp/ejs-syntax'

" Writing
Plugin 'junegunn/goyo.vim'
Plugin 'reedes/vim-pencil'
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'reedes/vim-litecorrect'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Colorscheme
set t_Co=256
colorscheme wombat256mod

" Sets title
set title titlestring=

" Syntax Hilighting
syntax on

" Indentation Settings
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
filetype plugin indent on

" copy and paste
set pastetoggle=<C-o>
vnoremap <C-c> "+yi
vnoremap <C-x> "+c
vnoremap <C-v> c<ESC>"+p
inoremap <C-v> <ESC>"+pa

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" ctrl-f to recursively search files
nnoremap <C-f> :Ack

" semicolon / colon
noremap ,c :cd ~/code<cr>
" noremap ; :
" noremap : ;

" jj to escape
inoremap jj <Esc>

" kk to escape
inoremap kk <Esc>

" space goes to insert mode
nnoremap <Space> i

" - & _ move lines around
noremap - ddp
noremap _ ddkkp

" > and < indent and unindent
nnoremap > >>
nnoremap < <<

" <leader> ev to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" <leader> sv to source .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Search Hightlight Toggle
set nohlsearch
nnoremap <silent> <C-N> :se invhlsearch<CR>

" Search as you type
set incsearch

" Ctrl-T to toggle NerdTree
noremap <C-t> :NERDTreeTabsToggle<CR>
inoremap <C-t> <Esc>:NERDTreeTabsToggle<CR>

" Switch between windows, maximizing the current window
nnoremap <C-J> <C-W>j<C-W>_ 
nnoremap <C-K> <C-W>k<C-W>_

" Line Numbers
set number

" Current marker postion
set ruler

" Set Statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Git Gutter
set updatetime=250
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_added = '❖'
highlight GitGutterAdd guifg = '#A3E28B'

" Statusline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \ 'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

"" Table Mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'


function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  else
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END

let g:vim_markdown_folding_disabled = 1

