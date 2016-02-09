"---[ vimrc ]---------------------------------------------------------
" by: grant welch
"---[ notes ]---------------------------------------------------------
" q· record to some register, <number>@· to replay macro
" m· mark a location, `· return to the mark
" *  search forward for word under cursor, # search backward
" >> indent current line
"---[ nocompatible ]--------------------------------------------------
  set nocompatible
"---[ vundle ]--------------------------------------------------------
  set rtp+=~/.vim/bundle/Vundle.vim
"---[ plugins ]-------------------------------------------------------
  call vundle#begin()
  " VIM Improvements
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'majutsushi/tagbar'
    Plugin 'mbbill/undotree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'godlygeek/tabular'
    Plugin 'tomasr/molokai'
    Plugin 'sanscore/badwolf'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'tpope/vim-repeat'
    Plugin 'airblade/vim-gitgutter'
    " native color picker
    Plugin 'KabbAmine/vCoolor.vim'
    " consistentency between tmux pane and vim window movement
    Plugin 'christoomey/vim-tmux-navigator'
    " Enhancements to netrw
    Plugin 'tpope/vim-vinegar'
  " RUBY
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-rake'
    Plugin 'tpope/vim-rails'
    Plugin 'tpope/vim-rbenv'
    Plugin 'tpope/vim-bundler'
    Plugin 'tpope/vim-cucumber'
    Plugin 'tpope/vim-haml'
    " run ruby in vim; depends on 'gem install seeing_is_believing'
    Plugin 't9md/vim-ruby-xmpfilter'
  " Coding
    Plugin 'AndrewRadev/splitjoin.vim'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'scrooloose/syntastic'
    Plugin 'klen/python-mode'
    Plugin 'Chiel92/vim-autoformat'
    Plugin 'tpope/vim-endwise'
    Plugin 'kchmck/vim-coffee-script'
  " Completion
    Plugin 'ervandew/supertab'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
  " In Tim Pope We Trust
    " Vim-Sensible sets some univerally accepted vim defaults
    Plugin 'tpope/vim-sensible'
    " Vim-Unimpaired adds square bracket mappings
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-dispatch'

  "
  " Here Be Dragons
  "
  Plugin 'file:///Users/u205/work/vim-tmux'
  call vundle#end()
"---[ directories ]---------------------------------------------------
"---[ swap ]----------------------------------------------------------
  if !isdirectory($HOME . "/tmp/vim/swap")
    silent! call mkdir($HOME . "/tmp/vim/swap", "p")
  endif
  set directory=~/tmp/vim/swap//,~/tmp//
"---[ backup ]--------------------------------------------------------
  if !isdirectory($HOME . "/tmp/vim/backup")
    silent! call mkdir($HOME . "/tmp/vim/backup", "p")
  endif
  set backupdir=~/tmp/vim/backup//,~/tmp//
"---[ undo ]----------------------------------------------------------
  if has("persistent_undo")
    if !isdirectory($HOME . "/tmp/vim/undo")
      silent! call mkdir($HOME . "/tmp/vim/undo", "p")
    endif
    set undodir=~/tmp/vim/undo/,~/tmp/
    set undofile
  endif
"---[ options ]-------------------------------------------------------
  set autoindent      " always set autoindenting on
  set autoread        " reread file if unchanged in vim and modified outside of vim
  set background=dark " dark background
  set colorcolumn=80  " add visual demarkation at 80 char
  set copyindent      " copy the previous indentation on autoindenting
  set dictionary+=/usr/share/dict/words
  set encoding=utf-8  " use utf-8 for encoding
  set expandtab       " use spaces in place of tabs
  set fileformat=unix " default to unix file format
  set foldlevelstart=99 " start vim unfolded
  set foldmethod=indent " fold based on indent level
  set formatoptions+=j  " remove comment leader when joining lines
  set formatoptions+=l  " do not break up lines in insert mode
  set formatoptions+=r  " add comment leader in insert mode
  set hidden          " hide buffers
  set history=1000    " remember more commands and search history
  set hlsearch        " highlight search terms
  set ignorecase      " ignore case when searching
  set linebreak       " use linebreak wrapping
  set list            " list special chars, see listchars
  set listchars=trail:·,tab:»·,extends:>,precedes:<,nbsp:+
  set noequalalways   " prevent vim from resizing windows
  set noerrorbells    " don't beep
  set nowrap          " don't wrap
  set number          " show line numbers
  set ruler           " show cursor position
  set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
  set shiftwidth=2    " number of spaces to use for autoindenting
  set shortmess+=I    " removes intro message
  set showbreak=↪     " change the wrap character
  set showcmd         " show command is it's typed
  set showmatch       " set show matching parenthesis
  set smartcase       " ignore case if search pattern is all lowercase, case-sensitive otherwise
  set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop
  set softtabstop=2
  set spelllang=en_us
  set splitbelow      " split under the current window
  set splitright      " split right of the current window
  set tabstop=2       " a tab is two spaces
  set textwidth=0     " prevent hard wrapping
  set thesaurus+=~/.vim/mthesaur.txt
  set timeoutlen=3000 " mapping timeouts at 3secs
  set title           " change the terminal's title
  set ttimeoutlen=100 " keycode timeouts at 1/10sec
  set undolevels=1000 " use many muchos levels of undo
  set virtualedit=onemore " cursor goes past last char
  set visualbell      " don't beep
  set wildmode=longest:full,full " Tab upto longest unique portion of string, then tab through suggestions
  set winminheight=0  " hide windows completely
  set winminwidth=0   " hide windows completely
  set wrapmargin=0    " prevent hard wrapping
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
"---[ highlighting ]--------------------------------------------------
  if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
  endif

  if &t_Co >= 256 || has("gui_running")
    colorscheme badwolf
    "highlight 80th column
    highlight ColorColumn ctermbg=196 guibg=#ff2c4b

    "highlight text that runs over 80 chars
    highlight OverLength ctermbg=196 guibg=#ff2c4b ctermfg=white
    match OverLength /\%81v.\+/

    highlight ExtraWhitespace ctermbg=red guibg=red
    " highlight trailing spaces
    match ExtraWhitespace /\s\+$/
    " match in all windows, not just current window
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " don't highlight in insert mode
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    " highlight when leaving insert mode
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    " clear when buffer is removed from window
    autocmd BufWinLeave * call clearmatches()
  endif
"---[ gui ]-----------------------------------------------------------
  if has("gui_running")
    set guioptions+=a " copy Visual selection to c-p buffer
    set guioptions+=e " use GUI tabline
    set guioptions+=m " add menu bar
    set guioptions+=g " grey inactive menu items
    set guioptions+=t " include tearoff menu items
    set guioptions+=T " include Toolbar
    set guioptions+=r " show vertical scrollbar
    set guioptions+=b " show bottom scrollbar

    set lines=40    " gvim default to 40 lines
    set columns=88  " gvim default to 88 columns
  else
  endif
"---[ mappings ]------------------------------------------------------
  " 'jj' to Esc and keep cursor at its current location
  inoremap jj <Esc>l
  " let j/k move through wrapped lines
  nnoremap j gj
  nnoremap k gk
  " make Y consistent with D and C; yank rest of line, not the whole line
  nnoremap Y y$
  " no more help
  nnoremap <F1> <nop>
  " no Ex mode
  nnoremap Q <nop>
  " no more manpages
  nnoremap K <nop>
  " ZJ quits all windows
  nnoremap ZJ :qa<CR>
  " space open/closes folds
  nnoremap <space> za
  " Change working directory to that of current file
  cabbrev cwd lcd %:p:h
  " Write no a write-protected file with root
  cabbrev w!! %!sudo tee > /dev/null %
  " Typing h<Space> will open help in a vertical split
  cabbrev h vert help
"---[ leader mappings ]-----------------------------------------------
  let mapleader=","   " change the mapleader from \ to ,
  " Clipboard mappings
    " yank entire buffer to clipboard
    nnoremap <Leader>ga :%y+<Enter>
    " put everything from clipboard
    nnoremap <Leader>gp "*p
    nnoremap <Leader>gP "*P
    " Visual Mode Del/Yank/Put
    vnoremap <Leader>gx "*d
    vnoremap <Leader>gy "*y
    vnoremap <Leader>gp "-d"*P
  " Inc/Dec numbers, recover C-a which is trumped by tmux
  nnoremap <Leader>a <C-a>
  nnoremap <Leader>x <C-x>
  " Quickly edit/source the vimrc file
  nnoremap <Leader>ve :e $MYVIMRC<CR>
  nnoremap <Leader>vs :so $MYVIMRC<CR>
  " toggle syntax highlighting
  nnoremap <Leader>S :call ToggleSyntax()<CR>
  " windows
  nnoremap <Leader>w <c-w>
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
  " Horizontal bars; type 'Yr-' 'Y--'
  iabbrev Yr "---[ ]--------------------------------------------------------------
  iabbrev Y- "--------------------------------------------------------------------
  " Timestamps
  " date standard, date/time
  iabbrev Yds     <C-R>=strftime("%Y-%m-%d")<CR>
  iabbrev Ydts    <C-R>=strftime("%Y-%m-%d - %X")<CR>
  " long form date, date/time
  iabbrev Ydl     <C-R>=strftime("%b %d, %Y")<CR>
  iabbrev Ydtl    <C-R>=strftime("%b %d, %Y - %X")<CR>
"---[ Plugins ]-------------------------------------------------------
"---[ airline ]-------------------------------------------------------
  " Disable autoloading plugins
  let g:airline#extensions#disable_rtp_load = 1
  " Allow one space after tabs for multiline comments /** */
  let g:airline#extensions#whitespace#mixed_indent_algo = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " Using Liberation Mono for Powerline, 13pt
  let g:airline_left_sep           = ''
  let g:airline_left_alt_sep       = ''
  let g:airline_right_sep          = ''
  let g:airline_right_alt_sep      = ''
  let g:airline_symbols.branch     = ''
  let g:airline_symbols.crypt      = '🔒'
  let g:airline_symbols.linenr     = ''
  let g:airline_symbols.readonly   = ''
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_theme              = 'badwolf'
  nnoremap <Leader>A <Esc>:AirlineToggle<CR>
"---[ Buffer Explorer ]-----------------------------------------------
  " Show no name buffers
  let g:bufExplorerShowNoName = 1
"---[ CtrlP ]---------------------------------------------------------
  let g:ctrlp_cmd               = "CtrlPMixed"
  let g:ctrlp_working_path_mode = 0
"---[ GitGutter ]-----------------------------------------------------
  " Toggle GitGutter
  nnoremap <Leader>G :GitGutterToggle<CR>
"---[ Indent Guide ]--------------------------------------------------
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_auto_colors = 0
  augroup IndentGuideColors
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg='121212' ctermbg=233
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='1c1c1c' ctermbg=234
  augroup END
"---[ NERDTree ]------------------------------------------------------
  nnoremap <Leader>N <Esc>:NERDTreeToggle<CR>
"---[ netrw ]---------------------------------------------------------
  nnoremap <Leader>E :Explore<CR>
"---[ pymode ]--------------------------------------------------------
  let g:pymode_rope            = 0
  let g:pymode_lint_on_write   = 0
  let g:pymode_lint_cwindow    = 0
  let g:pymode_breakpoint_bind = '<Leader>pb'
  let g:pymode_run_bind        = '<Leader>pr'
  let g:pymode_doc_bind        = '<Leader>pd'
"---[ ruby ]----------------------------------------------------------
  " vim-ruby, private/protect on the same level as module/class
  let g:ruby_indent_access_modifier_style = 'outdent'
  " vim-ruby-xmpfilter
  let g:xmpfilter_cmd = "seeing_is_believing"
  augroup VimRubyXMPFilter
    autocmd!
    autocmd FileType ruby nmap <buffer> <Leader>rm <Plug>(seeing_is_believing-mark)
    autocmd FileType ruby nmap <buffer> <Leader>rc <Plug>(seeing_is_believing-clean)
    autocmd FileType ruby nmap <buffer> <Leader>rx <Plug>(seeing_is_believing-run_-x)
    autocmd FileType ruby nmap <buffer> <Leader>rr <Plug>(seeing_is_believing-run)
  augroup END
"---[ SuperTab ]------------------------------------------------------
  let g:SuperTabDefaultCompletionType = '<C-n>'
"---[ Syntastic ]-----------------------------------------------------
  highlight SyntasticError guibg=#FF0000
  let g:syntastic_python_checkers = ['pylint', 'pep8']
  nnoremap <Leader>sc <Esc>:SyntasticCheck<CR>
"---[ Tabular ]-------------------------------------------------------
  " ,t= to align '='; ,T: to align ':' after a word
  nmap <silent> <Leader>t :call TabularHelper()<CR>
  vmap <silent> <Leader>t :<C-U>call TabularHelper(visualmode())<CR>
  nmap <silent> <Leader>T :call TabularHelper('', 'zs')<CR>
  vmap <silent> <Leader>T :<C-U>call TabularHelper(visualmode(), 'zs')<CR>
  function! TabularHelper(...)
    let l:a1 = ''
    let l:a2 = ''
    let l:chr = getchar()
    let l:chr = nr2char(l:chr)
    if exists('a:1')
      let l:a1 = a:1
    endif
    if exists('a:2')
      let l:chr = l:chr . '\' . a:2
      let l:a2 = a:2
    endif
    if l:a1 ==# "v" || l:a1 ==# "V" || l:a1 ==# "\<C-V>"
      silent! exec ":'<,'>Tabularize /" . l:chr
    else
      silent! exec ":Tabularize /" . l:chr
    endif
  endfunction
"---[ Tagbar ]--------------------------------------------------------
  if filereadable("/usr/local/Cellar/ctags/5.8/bin/ctags")
    let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8/bin/ctags"
  endif
  " nnoremap <Leader>T <Esc>:TagbarToggle<CR>
"---[ UltiSnips ]-----------------------------------------------------
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"---[ Undotree ]------------------------------------------------------
  nnoremap <Leader>U <Esc>:UndotreeToggle<CR>
"---[  vColor ]-------------------------------------------------------
  let g:vcoolor_map = '<Leader>cc'
  let g:vcool_ins_rgb_map = '<Leader>cr'
  let g:vcool_ins_hsl_map = '<Leader>ch'
  let g:vcool_ins_rgba_map = '<Leader>ca'
"---[ YouCompleteMe ]-------------------------------------------------
  let g:ycm_path_to_python_interpreter = "/usr/bin/python"
  let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

"---[ sundry ]--------------------------------------------------------
function! Carousel()
  let themes = split(globpath(&runtimepath, 'colors/*.vim'), '\n')
  let i = 0
  for theme in themes
    let themes[i] = fnamemodify(theme, ':t:r')
    let i = i + 1
  endfor
  let curr_index = index(themes, g:colors_name)
  let next_theme = get(themes, curr_index+1, get(themes, 0))
  try
    execute 'colorscheme '.next_theme
    redraw
    echo next_theme
  catch
    echo "Failed to load colorscheme '.next_theme
  endtry
endfunction

nnoremap <silent> <Leader>tc :call Carousel()<cr>
cnoremap %% <C-R>=expand('%:h').'/'<CR>
