let mapleader=","
call plug#begin('~/.local/share/nvim/plugged')
Plug 'SirVer/ultisnips'
Plug 'ap/vim-css-color'
Plug 'auwsmit/vim-active-numbers'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction
function! s:GotoOrOpen(command, ...)
	for file in a:000
		if a:command == 'e'
			exec 'e ' . file
		else
			exec "tab drop " . file
		endif
	endfor
endfunction
command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * %s/\s\+$//e
autocmd CursorHold * silent call CocActionAsync('highlight')
let g:fzf_action = {
	\ 'return': 'GotoOrOpen tab',
	\ 'ctrl-h': 'edit',
	\ 'ctrl-j': 'split',
	\ 'ctrl-k': 'vsplit' }
let g:fzf_buffers_jump = 1
let g:UltiSnipsExpandTrigger="<c-c>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ycm_show_diagnostics_ui = 0
let g:sneak#streak = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
let g:sneak#absolute_dir = 1
let g:vimwiki_list = [{'path': '~/docs/notes/', 'syntax': 'markdown', 'ext': '.md'}]
set encoding=utf-8
set noexpandtab tabstop=8 shiftwidth=8
set scrolloff=999 sidescroll=6
set number norelativenumber
set nocursorline
set noshowcmd noshowmode
set lazyredraw
set confirm
set list listchars=eol:¬,tab:›\ ,trail:~,extends:>,nbsp:•
set hlsearch incsearch ignorecase smartcase gdefault
set undofile undolevels=5000 undodir=~/.cache/undo/
set noswapfile nobackup nowritebackup
set splitright splitbelow
set termguicolors
filetype plugin on
syntax on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fzf shortcuts
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <C-s> :Snippets<CR>
xmap ga <Plug>(EasyAlign)
map s <Plug>Sneak_s
map S <Plug>Sneak_S
nnoremap <space><space> :nohlsearch<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
xnoremap <silent> p p:let @"=@0<CR>
"copying and pasting to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p
"select the inserted text
nnoremap gV `[v`]
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
"change visual and visual block around
nnoremap v <C-V>
xnoremap v <C-V>
nnoremap <C-V> v
xnoremap <C-V> v
"keep selection when changing indent
xnoremap <  <gv
xnoremap >  >gv
nnoremap jj <nop>
nnoremap kk <nop>
nnoremap <leader>s :w<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
