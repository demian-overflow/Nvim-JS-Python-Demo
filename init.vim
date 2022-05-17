" this will install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
    
set mouse=a
set number
set hidden
set expandtab
set tabstop=2
set shiftwidth=2

filetype plugin indent on
let mapleader = " "
if (has("temguicolors"))
	set termguicolors
endif
" VimWiki prerequisites
set nocompatible
filetype plugin on
syntax on

let g:netrw_banner=0
let g:markdown_fenced_lkanguages = ['javascript', 'js=javascript', 'json=javascript']

" Bind <leader>+V combination to edit this file
nnoremap <leader>v :e $MYVIMRC<CR>
call plug#begin('~/.neovim-plugins')

" here you'll add all the plugins needed
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting

Plug 'tomasiser/vim-code-dark'

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'maxmellon/vim-jsx-pretty' 
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'szw/vim-maximizer'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kassio/neoterm'
Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'janko/vim-test'
Plug 'puremourning/vimspector'

" PDF reader
Plug 'makerj/vim-pdf'

call plug#end()

colorscheme codedark
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

" Git lightline
let g:lightline = {
	\ 'active': {
	\	'left': [['mode', 'paste'],
	\		['gitbranch', 'readonly', 'filename', 'modified']]
	\},
	\'component_function': {
	\	'gitbranch': 'gitbranch#name'
	\},
	\'colorscheme': 'codedark',
	\}

lua require'nvim-tree'.setup {}

" kyazdani42/nvim-tree.lua
nnoremap <C-n> :NvimTreeToggle<CR>

" szw/vim-maximizer
nnoremap <leader> m : MaximizerToggle!<CR>

" kassio/neoterm
let g:neoterm_default_mod = 'vertical'
let g:neoterm_size = 60
let g:neoterm_autoinsert = 1
nnoremap <leader>Q :Ttoggle<CR>
inoremap <c-q> <Esc>:Ttoggle<CR>
tnoremap <c-q> <c-\><c-n>:Ttoggle<CR>

" sbdchd/neoformat
nnoremap <leader> F :Neoformat prettier<CR>

" junegunn/fzf.vim
nnoremap <leader><space> :GFiles<CR>
nnoremap <leader>ff :Rg<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
	\ "find. -path '*/\.*' -renu -o -print \| sed '1d;s:^..::'",
	\ fzf#wrap({'dir': expand('%:p:h')}))
if has('nivm')
	au! TermOpen * tnoremap <buffer> <Esc> <c-/><c-n>
	au! FileType fzf tunmap <buffer> <Esc>
endif

" tpope/vim-fugitive
nnoremap <leader>gg :G<cr>

" neovim/nvim-lspconfig and nvim-lug/completion-nvim
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }

nnoremap <silent> gd	<cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh	<cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH	<cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gD	<cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr	<cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR	<cmd>lua vim.lsp.buf.rename()<CR>

" janko/vim-test
nnoremap <silent> tt :TestNearest<CR>
nnoremap <silent> tf :TestFile<CR>
nnoremap <silent> ts :TestSuite<CR>
nnoremap <silent> t_ :TestLast<CR>
let test#strategy = "neovim"
let test#neovim#term_position = "vertical"

" puremourning/vimspector
nnoremap <leader>da :call vimspector#Launch()<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <S-k> :call vimspector#StepOut()<CR>
nnoremap <S-l> :call vimspector#StepInto()<CR>
nnoremap <S-j> :call vimspector#StepOver()<CR>
nnoremap <leader>d_ :call vimspector#Restart()<CR>
nnoremap <leader>dn :call vimspector#Continue()<CR>
nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
nnoremap<leader>dh :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>de :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>

