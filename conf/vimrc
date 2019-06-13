set nocompatible
set clipboard=unnamed,autoselectplus

" -----------------------------------------------
" encoding
" -----------------------------------------------
set enc=utf-8
set fencs=utf-8,iso-2022-jp,sjis,enc-jp

" -----------------------------------------------
" indent
" -----------------------------------------------
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
set backspace=indent,eol,start

" -----------------------------------------------
" search
" -----------------------------------------------
set wrapscan
set hlsearch
set ignorecase
set smartcase
set incsearch

" -----------------------------------------------
" backup
" -----------------------------------------------
set nobackup
"set backup
"set backupdir=~/.vim/backup

" -----------------------------------------------
" display
" -----------------------------------------------
set background=dark
set showcmd
set showmatch
set number
set wrap
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set scrolloff=5
set laststatus=2

set hidden

" -----------------------------------------------
" always center if search
" -----------------------------------------------
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" -----------------------------------------------
" current directory
" -----------------------------------------------
au BufEnter * execute ":lcd " . expand("%:p:h")

" -----------------------------------------------
"  Plugin
"
"  How to install
"   $ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh
"   $ sh ./install.sh
"   $ rm install.sh
"  Or Windows
"   mkdir -p ~/.vim/bundle
"   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"
"  How to processing
"    :NeoBundleInstall or :NeoBundleClean
"
"  Please compile vimproc
"    cd ~/.vim/bundle/vimproc && make
" -----------------------------------------------

filetype off

if has('vim_starting')
  if &compatible
    set nocompatible " Be improved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/vimproc'

NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kannokanno/previm'

NeoBundle 'thinca/vim-zenspace'

call neobundle#end()

filetype plugin indent on
filetype indent on
syntax on

NeoBundleCheck

" for neocompl ---------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


" for minibufexpl ------------------------------------------------------------
let g:miniBufExplorerMoreThanOne = 0    " always show
let g:miniBufExplMapWindowNavVim=1      " move hjkl

" for nerdtree ---------------------------------------------------------------
let NERDTreeShowHidden = 1              " show hidden file

" auto show nerdtree (if no argument)
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * execute 'NERDTree ./'
endif

nmap ,t [nerdtree]
nnoremap <silent> [nerdtree] :NERDTreeToggle<CR>

" for unite ------------------------------------------------------------------
let g:unite_enable_start_insert = 0
let g:unite_source_file_mru_limit = 50
let g:unite_source_file_mru_filename_format = ''

nmap ,u [unite]
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

" for unite-grep -------------------------------------------------------------
let g:unite_source_grep_max_candidates = 200
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

if executable('ag')
" ------------------------------------------
"  How to install ag
"    $ git clone https://github.com/ggreer/the_silver_searcher
"    $ sudo apt-get install automake libpcre3-dev liblzma-dev
"    $ cd the_silver_searcher && ./build.sh
" ------------------------------------------
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> [unite]r :<C-u>UniteResume search-buffer<CR>

vnoremap ,g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" for previm -----------------------------------------------------------------
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:previm_open_cmd = ''

nmap ,p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

