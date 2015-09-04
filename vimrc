"---[ vimrc ]--------------------------------------------------------
" by: grant welch
"---[ notes ]--------------------------------------------------------
" q· record to some register, <number>@· to replay macro
" m· mark a location, `· return to the mark
" * search forward for word under cursor, # search backward
" >> indent current line

"---[ nocompatible ]-------------------------------------------------
  set nocompatible

"---[ vundle ]-------------------------------------------------------
  set rtp+=~/.vim/bundle/Vundle.vim

"---[ plugins ]------------------------------------------------------
  call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'
  " Ruby plugin
  Plugin 'vim-ruby/vim-ruby'
  " add ⌘ r to run ruby code
  Plugin 'henrik/vim-ruby-runner'
  " Vim-Sensible sets some univerally accepted vim defaults
  Plugin 'tpope/vim-sensible'
  " buffer explorer provides a menu to switch buffers
  Plugin 'jlanzarotta/bufexplorer'
  " NerdTree provides a file tree to navigate a directory structure
  Plugin 'scrooloose/nerdtree'
  " Ctrl+P opens files using fuzzy search
  Plugin 'kien/ctrlp.vim'
  " Tagbar provides easy navigational access to class, func, etc definitions
  Plugin 'majutsushi/tagbar'
  " Undotree provides better access to VIM undo structure
  Plugin 'mbbill/undotree'
  " Vim-Fugitive is a git wrapper, ex: :Git status; :Git branch
  Plugin 'tpope/vim-fugitive'
  " Vim-GitGutter shows git diff lines in the 'gutter' (left of line numbers)
  Plugin 'airblade/vim-gitgutter'
  " Python-mode turns VIM into a Python IDE
  Plugin 'klen/python-mode'
  " Syntastic does syntax checking
  Plugin 'scrooloose/syntastic'
  " Requirements for snipmate, below
  Plugin 'marcweber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  " Snipmate provides UltiSnips functionality
  Plugin 'garbas/vim-snipmate'
  " vim-snippets provides the actual snippets
  Plugin 'honza/vim-snippets'
  " Vim-Surround provides easy shortcuts to change surrounding quotes, brackets, etc
  Plugin 'tpope/vim-surround'
  " Vim-Airline makes pretty status lines
  Plugin 'bling/vim-airline'
  " Tabular filter and align text
  Plugin 'godlygeek/tabular'
  " Molokai is a high-contrast, colorful colortheme
  Plugin 'tomasr/molokai'
  " Badwolf, ditto; the original sjl version lacks contrasting Diff colors
  " Plugin 'sjl/badwolf'
  Plugin 'alx741/badwolf'
  call vundle#end()

"---[ options ]------------------------------------------------------
" vim-sensible handles backspace, incsearch
  set shortmess+=I    " removes intro message
  set showcmd         " show command is it's typed
  set ruler           " show cursor position
  set number          " show line numbers
  set tabstop=2       " a tab is four spaces
  set shiftwidth=2    " number of spaces to use for autoindenting
  set expandtab       " use spaces in place of tabs
  set smarttab        " insert tabs on the start of a line according to
                      "    shiftwidth, not tabstop
  set autoindent      " always set autoindenting on
  set copyindent      " copy the previous indentation on autoindenting
  set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
  set showmatch       " set show matching parenthesis
  set ignorecase      " ignore case when searching
  set smartcase       " ignore case if search pattern is all lowercase,
                      "    case-sensitive otherwise
  set hlsearch        " highlight search terms
  set title           " change the terminal's title
  set visualbell      " don't beep
  set noerrorbells    " don't beep
  set nobackup        " don't save a backup file
  set noswapfile      " don't creat a swap file
  set history=1000    " remember more commands and search history
  set undolevels=1000 " use many muchos levels of undo
  set timeoutlen=4000 " extend timeout length to 4 seconds
  set fileformat=unix " default to unix file format
  set nowrap          " don't wrap
  set nolist          " don't list special chars, set listchars
  set listchars=trail:·,tab:»·,extends:>,precedes:<,nbsp:+
  set linebreak       " use linebreak wrapping
  set scrolloff=10    " minimum number of rows before/after of cursor
  set sidescrolloff=10  " minimum number of cols left/right of cursor
  set textwidth=0     " prevent hard wrapping
  set wrapmargin=0    " prevent hard wrapping
  set colorcolumn=80  " add visual demarkation at 80 char
  set showbreak=↪     " change the wrap character
  set fo+=l           " do not break up lines in insert mode
  set fo+=r           " add comment leader in insert mode
  "set fo+=j           " remove comment leader when joining lines
  set fdls=99         " start vim unfolded
  set foldmethod=indent   " fold based on indent level

  " stop hitting shift all day
  nnoremap ; :
  filetype plugin indent on

"---[ statusline ]----------------------------------------------------
  set laststatus=2            " always display status line
  set statusline=%F%m%r%h%w\  " display pathname and flags
  set statusline+=\|b=%n\|    " buffer number
  set statusline+=f=%{&ff}    " format (unix or windows)
  set statusline+=\|t=%Y      " filetype (for syntax hilighting)
  set statusline+=\|%L        " number of lines in file
  set statusline+=\|p=%l,%v\| " line and column position in file
  set statusline+=%=%p%%\     " right justify; place in file by percentage
  set statusline+=%{strftime(\"%m/%d/%y\ %H:%M\")}

"---[ airline ]-------------------------------------------------------
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_theme='badwolf'

"---[ buffers\windows ]-----------------------------------------------
  set hidden          " hide buffers
  set wmh=0           " hide windows completely
  set wmw=0           " hide windows completely
  set splitbelow      " split under the current window
  set splitright      " split right of the current window
  set noequalalways   " prevent vim from resizing windows

"---[ highlighting ]-------------------------------------------------
  set background=dark

  if &t_Co >= 256 || has("gui_running")
    colorscheme badwolf
    let &colorcolumn=join(range(81,999),",")
  endif

  if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
  endif

"---[ gui ]-----------------------------------------------------------
  if has("gui_running")
    set go+=a       " copy Visual selection to c-p buffer
    set go+=e       " use GUI tabline
    set go+=m       " add menu bar
    set go+=g       " grey inactive menu items
    set go+=t       " include tearoff menu items
    set go+=T       " include Toolbar
    set go+=r       " show vertical scrollbar
    set go+=b       " show bottom scrollbar

    set lines=40    " gvim default to 40 lines
    set columns=88  " gvim default to 88 columns
  else
  endif

"---[ navigation ]----------------------------------------------------
  " let j/k move through wrapped lines
  nnoremap j gj
  nnoremap k gk
  " Easy window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

"---[ mappings ]------------------------------------------------------
  " make Y consistent with D and C; yank rest of line, not the whole line
  nnoremap Y y$
  " no more help
  nnoremap <F1> <nop>
  " no Ex mode
  nnoremap Q <nop>
  " no more manpages
  nnoremap K <nop>
  " Change working directory to that of current file
  cnoremap cwd lcd %:p:h
  " Write no a write-protected file with root
  cnoremap w!! %!sudo tee > /dev/null %
  " space open/closes folds
  nnoremap <space> za
"---[ leader mappings ]-----------------------------------------------
  let mapleader=","   " change the mapleader from \ to ,
  " Quickly edit/source the vimrc file
  nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
  nnoremap <silent> <leader>vs :so $MYVIMRC<CR>
  " clear search
  nnoremap <silent> <leader>/ :nohlsearch<CR>
  " toggle line numbers
  nnoremap  <leader>n :set number!<CR>
  " toggle relative line numbers
  nnoremap  <leader>r :set relativenumber!<CR>
  " toggle linebreak
  nnoremap <leader>lb :set linebreak! linebreak?<CR>
  " toggle list characters
  nnoremap  <leader>li :set list! list?<CR>
  " toggle line wrapping
  nnoremap <leader>lw :set wrap! wrap?<CR>
  " toggle spell checking
  nnoremap <leader>sp :set invspell<CR>
  " toggle syntax highlighting
  nnoremap <silent>  <leader>sh  :call ToggleSyntax()<CR>
  " toggle pastemode
  set pastetoggle=<leader>.
  " toggle cursorline
  nnoremap <leader>cl :set cul!<CR>
  " toggle cursorcolumn
  nnoremap <leader>cc :set cuc!<CR>
  " errors
    nnoremap <leader>el <Esc>:lnext<CR>
    nnoremap <leader>eL <Esc>:lprevious<CR>
    nnoremap <leader>ec <Esc>:cnext<CR>
    nnoremap <leader>eC <Esc>:cprevious<CR>
  " buffers
    " previous
    nnoremap  <leader>bp <Esc>:bprevious<CR>
    " next
    nnoremap  <leader>bn <Esc>:bnext<CR>
    " new
    nnoremap  <leader>bN <Esc>:enew<CR>
    " open BufExplorer
    nnoremap  <leader>be <Esc>:BufExplorer<CR>
  " tabs
    " previous
    nnoremap  <leader>tp <Esc>:tabprevious<CR>
    " next
    nnoremap  <leader>tn <Esc>:tabnext<CR>
    " new
    nnoremap  <leader>tN <Esc>:tabnew<CR>
    " list
    nnoremap  <leader>tl <Esc>:tabs<CR>
  " windows
    nnoremap  <leader>w <c-w>
  " plugins
    " toggle nerdtree
    nnoremap  <leader>N <Esc>:NERDTreeToggle<CR>
    " airline
    nnoremap <leader>a <Esc>:AirlineToggle<CR>
    " pymode
    let g:pymode_doc_bind = '<leader>pd'
    let g:pymode_run_bind = '<leader>pr'
    let g:pymode_breakpoint_bind = '<leader>pb'
    nnoremap <leader>pc <Esc>:PymodeLint<CR>
    " syntastic
    nnoremap <leader>sc <Esc>:SyntasticCheck<CR>
    " Tagbar
    nnoremap <leader>T <Esc>:TagbarToggle<CR>
    nnoremap <leader>wT 99<c-w>l
    " Undotree
    nnoremap <leader>u <Esc>:UndotreeToggle<CR>
"---[ functions ]-----------------------------------------------------
  "Toggle syntax highlighting on and off
  function! ToggleSyntax()
    if exists("g:syntax_on")
      syntax off
    else
      syntax enable
    endif
  endfunction
"---[ abbreviations ]-------------------------------------------------
  " Horizontal bars
  iab Yr "---[ ]---------------------------------------------------------------
  iab Y- "---------------------------------------------------------------------
  " Timestamps
  " date standard, date/time
  iab Yds     <C-R>=strftime("%Y-%m-%d")<CR>
  iab Ydts    <C-R>=strftime("%Y-%m-%d - %X")<CR>
  " long form date, date/time
  iab Ydl     <C-R>=strftime("%b %d, %Y")<CR>
  iab Ydtl    <C-R>=strftime("%b %d, %Y - %X")<CR>
"---[ Buffer Explorer ]-----------------------------------------------
  " Show no name buffers
  let g:bufExplorerShowNoName=1
"---[ Undotree ]------------------------------------------------------
  if has("persistent_undo")
    if !isdirectory($HOME . "/tmp/vim/undo")
      silent! call mkdir($HOME . "/tmp/vim/undo", "p")
    endif
    set undodir=~/tmp/vim/undo/
    set undofile
  endif
"---[ ctags ]---------------------------------------------------------
  if filereadable("/usr/local/Cellar/ctags/5.8/bin/ctags")
    let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8/bin/ctags"
  endif
