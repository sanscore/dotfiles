"---[ vimrc ]-------------------------------------------------------a-
" by: grant welch
"---[ notes ]--------------------------------------------------------
" q· record to some register, <number>@· to replay macro
" m· mark a location, `· return to the mark
" * search forward for word under cursor, # search backward
" == indent current line

"---[ nocompatible ]-------------------------------------------------
  set nocompatible

"---[ pathogen ]-----------------------------------------------------
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
  execute pathogen#infect('bundle/{}')
  call pathogen#helptags()

"---[ options ]------------------------------------------------------
" vim-sensible handles backspace, incsearch, listchars, and scrolloff
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
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_theme='badwolf'

"---[ formatting ]----------------------------------------------------
  set nowrap          " don't wrap
  set textwidth=0     " prevent hard wrapping
  set wrapmargin=0    " prevent hard wrapping
  set colorcolumn=80  " add visual demarkation at 80 char
  set showbreak=↪     " change the wrap character
  set nolist          " don't list special chars
  set fo+=l           " do not break up lines in insert mode
  set fo+=r           " add comment leader in insert mode
  "set fo+=j           " remove comment leader when joining lines
  set fdls=99         " start vim unfolded
  set foldmethod=indent   " fold based on indent level

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
  " no Ex mode
  nnoremap Q <nop>
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
  " toggle list characters
  nnoremap  <leader>l :set list! list?<CR>
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
    nnoremap  <leader>wn <c-w>n
    nnoremap  <leader>wN <Esc>:vne<CR>
    nnoremap  <leader>wp <c-w>p
    nnoremap  <leader>wq <c-w>q
    nnoremap  <leader>ws <c-w>s
    nnoremap  <leader>wv <c-w>v
    nnoremap  <leader>ww <c-w><c-w>
    nnoremap  <leader>wW <c-w>W
  " plugins
    " toggle nerdtree
    nnoremap  <leader>N <Esc>:NERDTreeToggle<CR>
    " airline
    nnoremap <leader>a <Esc>:AirlineToggle<CR>
    " pymode
    let g:pymode_doc_bind = '<leader>pd'
    let g:pymode_run_bind = '<leader>pr'
    let g:pymode_breakpoint_bind = '<leader>pb'
    let g:pymode_doc_bind = '<leader>pk'
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
