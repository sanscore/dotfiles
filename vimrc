"---[ vimrc ]--------------------------------------------------------
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
    execute pathogen#infect()
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
    let g:airline_section_a = airline#section#create_left(['mode', 'paste', 'iminsert'])
    let g:airline_section_b = airline#section#create(['%<', 'file'])
    let g:airline_section_c = airline#section#create(['filetype'])
    "let g:airline_section_gutter = airline#section#create([' ', 'readonly', '%='])
    let g:airline_section_x = airline#section#create_right(['tagbar'])
    let g:airline_section_y = airline#section#create_right(['%10(%l:%-2v %p%%%)'])
    let g:airline_section_z = airline#section#create_right(['hunks', 'branch'])
    "let g:airline_section_warning = airline#section#create(['syntastic', 'whitespace'])

    " change seperators
    let g:airline_left_sep = '▙'
    let g:airline_right_sep = '▟'

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
    set fo+=j           " remove comment leader when joining lines
    set fdls=99         " start vim unfolded

"---[ buffers\windows ]-----------------------------------------------
    set hidden          " hide buffers
    set wmh=0           " hide windows completely
    set wmw=0           " hide windows completely
    set splitbelow      " split under the current window
    set splitright      " split right of the current window
    set noequalalways   " prevent vim from resizing windows

"---[ navigation ]----------------------------------------------------
    " let j/k move through wrapped lines
    nnoremap j gj
    nnoremap k gk
    " Easy window navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
    " Window only/close shortcuts
    map <C-O> <C-W>o
    map <C-C> <C-W>c

"---[ highlighting ]-------------------------------------------------
    set background=dark

    if &t_Co >= 256 || has("gui_running")
        colorscheme molokai
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

"---[ mappings ]------------------------------------------------------
    " write system files
    cmap w!! w !sudo tee % >/dev/null
    " no Ex mode
    nnoremap Q <nop>
    " Change working directory to that of current file
    cmap cwd lcd %:p:h

"---[ leader mappings ]-----------------------------------------------
    let mapleader=","   " change the mapleader from \ to ,
    " Quickly edit/source the vimrc file
    nmap <silent> <leader>ve :e $MYVIMRC<CR>
    nmap <silent> <leader>vs :so $MYVIMRC<CR>
    " clear search
    nmap <silent> <leader>/ :nohlsearch<CR>
    " toggle line numbers
    map  <leader>n :set number!<CR>
    " toggle relative line numbers
    map  <leader>r :set relativenumber!<CR>
    " toggle list characters
    map  <leader>l :set list! list?<CR>
    " toggle pastemode
    set pastetoggle=<leader>.
    " buffers
        " previous
        map  <leader>bp <Esc>:bp<CR>
        " next
        map  <leader>bn <Esc>:bn<CR>
        " new
        map  <leader>bN <Esc>:enew<CR>
        " list
        map  <leader>bl <Esc>:ls<CR>
        " open BufExplorer
        map  <leader>be <Esc>:BufExplorer<CR>
    " tabs
        " previous
        map  <leader>tp <Esc>:tabp<CR>
        " next
        map  <leader>tn <Esc>:tabn<CR>
        " new
        map  <leader>tN <Esc>:tabnew<CR>
        " list
        map  <leader>tl <Esc>:tabs<CR>
    " windows
        map  <leader>ww <c-w><c-w>
        map  <leader>wp <c-w>p
    " plugins
        " toggle nerdtree
        map  <leader>N <Esc>:NERDTreeToggle<CR>
        " airline
        map <leader>a <Esc>:AirlineToggle<CR>
        " ctrlp
        let g:ctrlp_map = ''
        map <leader>p <Esc>:CtrlP<CR>
        " syntastic
        map <leader>c <Esc>:SyntasticCheck<CR>
        " Tagbar
        map <leader>T <Esc>:TagbarToggle<CR>
        map <leader>wT 99<c-w>l
        " Undotree
        map <leader>u <Esc>:UndotreeToggle<CR>
"---[ functions ]-----------------------------------------------------
    "Toggle syntax highlighting on and off with <leader>s
    function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
    endfunction

    nmap <silent>  <leader>x  :call ToggleSyntax()<CR>

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
    set undodir=~/tmp/vim_undo/
    set undofile
endif
