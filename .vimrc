set encoding=utf-8
set t_Co=256

set nocp
set nocompatible              " be iMproved, required
filetype off                  " required
let g:go_version_warning = 0
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'amiorin/vim-project'                   " Project listing with location and callbacks !
Plugin 'bagrat/vim-buffet'                  " Better tabline
Plugin 'bling/vim-bufferline.git'              " List buffers
Plugin 'bronson/vim-trailing-whitespace'       " I want to see trailing whitespace
Plugin 'cespare/vim-toml'                      " TOML support
Plugin 'chrisbra/csv.vim.git'                  " CSV tools
Plugin 'easymotion/vim-easymotion'             " Use ,,s or ,,f to access esaymotion
Plugin 'ervandew/screen'                       " Start shell in new tmux pane with ,sh
Plugin 'fatih/vim-go.git'                      " go support
Plugin 'glench/vim-jinja2-syntax'              " jinja support
Plugin 'godlygeek/tabular.git'                 " Format text
Plugin 'gu-fan/InstantRst'                     " supposedly start rst view in navigator...
Plugin 'gu-fan/riv.vim'                        " rst support
Plugin 'haya14busa/incsearch-easymotion.vim'   " Use EasyMotion with incsearch results
Plugin 'haya14busa/incsearch.vim'              " Clear incremental search '/'
Plugin 'honza/vim-snippets'                    " snippets
Plugin 'hynek/vim-python-pep8-indent'          " python indent
Plugin 'jceb/vim-orgmode'
Plugin 'junegunn/goyo.vim'                     " No distraction :Goyo (bugs)
Plugin 'justinmk/vim-sneak'                    " Two letters f: 'sxx'
Plugin 'KabbAmine/zeavim.vim'
Plugin 'lilydjwg/colorizer'                    " Colorize #fea8a1
Plugin 'majutsushi/tagbar.git'                 " List tags of current file
Plugin 'mhinz/vim-signify.git'                 " Show git diff in file
Plugin 'mileszs/ack.vim.git'
Plugin 'mkitt/tabline.vim.git'
Plugin 'moll/vim-bbye'                         " ,q to close buffer without changing layout
Plugin 'mtth/scratch.vim'                      " 'gs' to open scratch panel/window
Plugin 'nathanaelkane/vim-indent-guides'       " indent guides
Plugin 'osyo-manga/vim-over'                   " substitute preview
Plugin 'plasticboy/vim-markdown'               " md support
Plugin 'romainl/vim-cool'                      " hlsearch if searching
Plugin 'ryanoasis/vim-devicons'                " Nice icons
Plugin 'scrooloose/nerdcommenter.git'          " Comment your code with 's'
Plugin 'scrooloose/nerdtree.git'               " Current folder tree
Plugin 'scrooloose/syntastic'                  " Error checker and more
Plugin 'sheerun/vim-polyglot.git'              " Lot of language support
Plugin 'Shougo/denite.nvim'                    " Fuzzy finder (not used)
Plugin 'sickill/vim-pasta'                     " Better paste
Plugin 'SirVer/ultisnips'
Plugin 'tangledhelix/vim-kickstart'            " kickstart syntax
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-fugitive.git'                " Git command integretion :Gstatus
Plugin 'tpope/vim-rsi'                         " Readline key bindings! C-a C-k C-e etc
Plugin 'tpope/vim-speeddating.git'             " Increase or decrease dates
Plugin 'tpope/vim-surround'                    " Surround text with quotes or brackets or... use cs
Plugin 'tpope/vim-vinegar'
Plugin 'udalov/kotlin-vim'
Plugin 'unblevable/quick-scope'                " Show next or previous charcter to jump using f and co
Plugin 'ycm-core/youcompleteme'
Plugin 'vim-airline/vim-airline.git'
Plugin 'vim-airline/vim-airline-themes.git'
Plugin 'xuyuanp/nerdtree-git-plugin'           " Git status in nerdtree
Plugin 'stephpy/vim-yaml'
Plugin 'towolf/vim-helm'
call vundle#end()
syn on
set syntax=on
if has('gui_running')
	set background=dark
else
	set background=dark
endif
colorscheme solarized
filetype indent plugin on


" autocmd BufNewFile,BufRead *.vb set ft=vbnet
" autocmd BufNewFile,BufRead *.BAS set ft=vbnet
" autocmd BufNewFile,BufRead *.FRM set ft=vbnet
autocmd FileType sh set ts=4 sw=4 expandtab
autocmd FileType helm set ts=2 sw=2 expandtab
set nu

set mouse=a

set showmatch


set tabstop=4
set shiftwidth=4
set softtabstop=4

set incsearch

function Enable_hlsearch()
  if &readonly
	  set hlsearch
  endif
  autocmd! readonly
endfunction

augroup readonly
	autocmd!
	autocmd BufReadPost * call Enable_hlsearch()
augroup end
set hlsearch

set foldmethod=syntax

set cursorline
if exists('$TMUX')
	if &term =~ "xterm\\|rxvt"
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;#af8700\x7\<Esc>\<Esc>[6 q\<Esc>\\"
		let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]12;#d70000\x7\<Esc>\<Esc>[4 q\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;#93a1a1\x7\<Esc>\<Esc>[2 q\<Esc>\\"
		autocmd VimLeave * silent !echo -ne "\033]112\007"
	endif
	nnoremap [C :tabnext<CR>
	nnoremap [D :tabprevious<CR>
else
	if &term =~ "xterm\\|rxvt"
		let &t_SI = "\<Esc>]12;#af8700\x7\<Esc>[6 q"
		let &t_SR = "\<Esc>]12;#d70000\x7\<Esc>[4 q"
		let &t_EI = "\<Esc>]12;#93a1a1\007\<Esc>[2 q"
		autocmd VimLeave * silent !echo -ne "\033]112\007"
	endif
	if &term =~ "rxvt"
		nnoremap Oc :tabnext<CR>
		nnoremap Od :tabprevious<CR>
	elseif &term =~ "xterm"
		nnoremap [1;5C :tabnext<CR>
		nnoremap [1;5D :tabprevious<CR>
	endif
endif

let mapleader=","

"iab \se\ \section
"iab \ss\ \subsection
"iab \sss\ \subsubsection
"iab \b\ \begin{}<ENTER>\end{}
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
nmap <F9> :TagbarToggle<CR>
nmap <leader>tg :TagbarToggle<CR>
nmap <leader>tr :NERDTreeToggle<CR>
nmap <F8> :NERDTreeToggle<CR>
"nnoremap <C-S-Tab> :WSPrev<CR>
"nnoremap <C-Tab> :WSNext<CR>
"nnoremap <silent> <C-S-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <C-S-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
noremap <leader>nt :WSTabNew<CR>
noremap <Leader><Tab> :WSClose<CR>
noremap <Leader><S-Tab> :WSClose!<CR>
cnoreabbrev tbn tabnew
cnoreabbrev tabv tab sview +setlocal\ nomodifiable
cnoreabbrev vsb vertical belowright sbuffer
cnoreabbrev bv belowright vsplit
cabbrev bonly WSBufOnly

nmap <leader>fr :setlocal spell spelllang=fr_fr<CR>
nmap <leader>en :setlocal spell spelllang=en_us<CR>
nmap <leader>o o<Esc>k
nmap <leader>O O<Esc>j
nmap <leader>hs :set hlsearch!<CR>
nmap <leader>q :Bdelete<CR>
nmap <leader>Q :bufdo :Bdelete<CR>
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
hi Comment		ctermfg=249    ctermbg=NONE		 guifg=#b2b2b2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline#extensions#hunks#enabled = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips/"

if executable("rg")
	let g:ackgrp = 'rg --vimgrep --no-heading'
elseif executable("ag")
	let g:ackgrp = 'ag --vimgrep'
endif

autocmd BufNewFile,BufRead *.py IndentGuidesEnable

let g:tagbar_type_vbnet = {
    \ 'ctagstype' : 'vb',
    \ 'kinds'     : [
		\ 's:subroutine',
        \ 'f:function',
        \ 'v:variable',
        \ 'c:const',
		\ 'n:name',
		\ 'e:enum',
		\ 'd:call'
    \ ]
	\ }

let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"

set backspace=indent,eol,start
set t_kb=
set t_kD=[3~

nmap <leader>sh :ScreenShell<CR>
nmap <leader>ov :OverCommandLine<CR>
