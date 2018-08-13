"---[ vimrc ]---------------------------------------------------------
" by: grant welch
"---[ notes ]---------------------------------------------------------
" Font: Liberation Mono for Powerline, 13pt
" Movement:
"   hjkl              " Move 1 char left,down,up,right
"   Ctrl-O            " Move to older cursor postion; :jumps
"   Ctrl-I            " Move to newer cursor postion; :jumps
"   Ctrl-T            " Move to older tag entry; :tags
" Viminfo:
"   " pass info from one vim instance to another.
"   :wviminfo! ~/tmp/viminfo  " write viminfo
"   :rviminfo! ~/tmp/viminfo  " read viminfo
" Sessions:
"   vim -s [file]     " Start vim from a saved session
"   :mks [file]       " Save session
" Buffers:
"   :set buftype=·    " Alter current buffer; nofile,nowrite,<empty>
" Views:
"   :mkview           " Save the current view
"   :loadview         " Load a saved view to the current window
" Macros/Registers:
"   q·                " record Macro to register
"   Q·                " append Macro
"   @@                " replay previous Macro
"   <number>@·        " replay macro N times
"   "·p               " paste content of register
"   "·D               " delete line and save content to register
"   :redir @·         " Record ex cmd output
"   :redir END        " Stop recording
" Marks:
"   m·                " mark a location
"   `·                " return to the exact position of a Mark
"   '·                " return to row of a Mark
" Searching:
"   /pattern/         " searh
"   //                " redo previous search
"   *                 " search forward for word under cursor
"   #                 " search backward
"   :%s/pattern//gn   " count matches
" Help:
"   :h[elp]           " open help
"   :h :<cmd>         " help with a specific command
"   :h topic|map      " help with a topic or a normal mapping
"   :h v_|i_|c_<map>  " help with a visual|insert|ex mapping
"   :h 'option'       " help with an option; e.g. :set option
"   C-]               " In help, follow a link.
" Misc:
"   ga                " Character info
"---[ nocompatible ]--------------------------------------------------
  set nocompatible

"---[ plugins ]-------------------------------------------------------
" Vim8 packages located at .vim/pack/
" Update:
"   git submodule update --remotde
helptags ALL
"
" TODO: add .vim/pack/ to dotfiles
" TODO: checkout these plugins:
"   ShowMarks
"   vdebug

"---[ directories ]---------------------------------------------------
"---[ swap ]----------------------------------------------------------
  if !isdirectory($HOME . "/.vim/swap")
    silent! call mkdir($HOME . "/.vim/swap", "p")
  endif
  set directory=~/.vim/swap//,~/tmp//

"---[ backup ]--------------------------------------------------------
  if !isdirectory($HOME . "/.vim/backup")
    silent! call mkdir($HOME . "/.vim/backup", "p")
  endif
  set backupdir=~/.vim/backup//,~/tmp//
  set writebackup

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
  set cursorline
  set dictionary+=/usr/share/dict/words
  set encoding=utf-8  " use utf-8 for encoding
  set termencoding=utf-8
  set expandtab       " use spaces in place of tabs
  set fileformat=unix " default to unix file format
  set fillchars+=vert:\│ " Vertical sep w/ no gaps
  set fillchars+=fold:─  " Horizontal sep w/ no gaps
  set foldlevel=99 " start vim unfolded
  set foldlevelstart=99 " start vim unfolded
  set foldmethod=manual
  set formatoptions+=j  " remove comment leader when joining lines
  set formatoptions+=n  " format lists
  set formatoptions+=l  " do not break up lines in insert mode
  set formatoptions+=r  " add comment leader in insert mode
  set hidden          " hide buffers
  set history=1000    " remember more commands and search history
  set hlsearch        " highlight search terms
  set ignorecase      " ignore case when searching
  set iskeyword-=.    " . is never, _ever_ a keyword char
  set lazyredraw
  set linebreak       " use linebreak wrapping
  set nolist          " list special chars, see listchars
  set listchars=tab:»-
  set listchars+=extends:>
  set listchars+=nbsp:+
  set listchars+=precedes:<
  set listchars+=space:·
  set listchars+=trail:·
  set listchars+=eol:$
  set noequalalways   " prevent vim from resizing windows
  set noerrorbells    " don't beep
  set nowrap          " don't wrap
  set number          " show line numbers
  set ruler           " show cursor position
  set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
  set shiftwidth=2    " number of spaces to use for autoindenting
  set shortmess=a     " use all message abbreviatons to prevent hit-enter.
  set shortmess+=t    " Truncate messages
  set shortmess+=o    " overwrite message for writing a file
  set shortmess+=O    " overwrite message for reading a file
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
  set timeout         " mapping timeout
  set timeoutlen=1000 " mapping timeouts at 3secs
  set title           " change the terminal's title
  set undolevels=1000 " use many muchos levels of undo
  set virtualedit=block " cursor goes past last char
  set visualbell      " don't beep
  set winminheight=0  " hide windows completely
  set winminwidth=0   " hide windows completely
  set wrapmargin=0    " prevent hard wrapping
  set viminfo+=!      " global vars
  set viminfo+='1000  " save marks for last N files
  set viminfo+=/100   " N lines saved from the search history
  set viminfo+=:100   " N lines saved from the command history
  set viminfo+=<500   " N lines saved per register
  set viminfo+=s10    " disable search when starting
  set viminfo+=h      " disable search when starting
  filetype plugin indent on

"---[ statusline ]----------------------------------------------------
  set laststatus=2            " always display status line
  set statusline=%F%m%r%h%w\  " display pathname and flags
  set statusline+=\|b=%n\|    " buffer number
  set statusline+=f=%{&ff}    " format (unix or windows)
  set statusline+=\|t=%Y      " filetype (for syntax hilighting)
  set statusline+=\|%L        " number of lines in file
  set statusline+=\|p=%l,%v\| " line and column position in file
  set statusline+=%b\ %B
  set statusline+=%=%p%%\     " right justify; place in file by percentage
  set statusline+=%{strftime(\"%m/%d/%y\ %H:%M\")}

"---[ highlighting ]--------------------------------------------------
  set termguicolors

  if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
    " assume bash syntax for ambiguous shell scripts
    let g:is_bash=1
  endif

  if &t_Co >= 256 || has("gui_running")
    " colorscheme badwolf
    colorscheme PaperColor
  endif

  if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
  endif

"---[ gui ]-----------------------------------------------------------
  if has("gui_running")
    set guifont=Liberation\ Mono\ for\ Powerline:h13
    set guioptions=a " copy Visual selection to c-p buffer
    set guioptions+=c " use console dialogs
    set guioptions+=m " add menu bar
    set guioptions+=g " grey inactive menu items
    set guioptions+=t " include tearoff menu items
    set guioptions+=T " include Toolbar

    set lines=50
    set columns=120
  else
  endif

"---[ mappings ]------------------------------------------------------
  cnoremap %% <C-R>=expand('%:h').'/'<CR>
  " let j/k move through wrapped lines
  nnoremap j gj
  nnoremap k gk
  " make Y consistent with D and C; yank rest of line, not the whole line
  nnoremap Y y$
  " disable help mapping
  nnoremap <F1> <nop>
  " disable Ex mode mappings
  nnoremap Q <nop>
  nnoremap gQ <nop>
  " disable cedit mappings
  " noremap q: <nop>
  " noremap q/ <nop>
  " noremap q? <nop>
  " Change working directory to that of current file
  cabbrev cwd lcd %:p:h
  " Write no a write-protected file with root
  cabbrev w!! %!sudo tee > /dev/null %

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

"---[ autocommands ]--------------------------------------------------
"---[ personal touches ]----------------------------------------------
" augroup annoyances
"   autocmd!
"   autocmd Filetype * :set iskeyword-=.
" augroup END

" augroup myviews
"   autocmd BufWinLeave *.* mkview
"   autocmd BufWinEnter *.* silent loadview
" augroup END

augroup clearbg
  autocmd!
  autocmd VimEnter,Colorscheme * :hi Normal ctermbg=none
  autocmd VimEnter,Colorscheme * :hi NonText ctermbg=none
  autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=52
  autocmd VimEnter,Colorscheme * :hi OverLength ctermbg=52 ctermfg=white guibg=#592929
  autocmd VimEnter,Colorscheme * call UpdateOverLength()
augroup END

fun! UpdateOverLength()
  if &ft =~ '^\%(python\)$'
    setlocal colorcolumn=80
    match OverLength /\%80v.*/
  else
    setlocal colorcolumn=120
    match OverLength /\%120v.*/
  endif
endfun

augroup python
  autocmd!
  autocmd FileType python nnoremap <buffer> <silent> <Leader>ps oimport pdb; pdb.set_trace()<esc>
  autocmd FileType python nnoremap <buffer> <silent> <Leader>pS Oimport pdb; pdb.set_trace()<esc>
augroup END

"---[ file type fixes ]-----------------------------------------------
augroup md_fixes
  autocmd!
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown setlocal wrap linebreak nolist
augroup END

"---[ vertical help windows ]-----------------------------------------
augroup helpfiles
  autocmd!
  autocmd FileType help wincmd L
augroup END

"---[ Plugins ]-------------------------------------------------------
"---[ vim-plug ]------------------------------------------------------
  command! PU PlugUpdate | PlugUpgrade
"---[ airline ]-------------------------------------------------------
  nnoremap <Leader>A <Esc>:AirlineToggle<CR>
  let g:airline_theme           = 'badwolf'
  let g:airline_powerline_fonts = 1
  " Allow one space after tabs for multiline comments /** */
  let g:airline#extensions#whitespace#mixed_indent_algo = 1
  let g:airline#extensions#ale#enabled = 1

"---[ Buffer Explorer ]-----------------------------------------------
  " Show no name buffers
  let g:bufExplorerShowNoName = 1

"---[ vim-dispatch ]--------------------------------------------------
  autocmd FileType dex let b:dispatch = 'bash -lc "ppolicy %"'
  nnoremap <Leader>dd :Dispatch!<CR>
  nnoremap <Leader>ds :Start<CR>
  nnoremap <Leader>dm :Make!<CR>
  nnoremap <Leader>dn :Spawn<CR>

"---[ Commentary ]----------------------------------------------------
  augroup VimrcCommentary
    autocmd!
    autocmd FileType dosini setlocal commentstring=#\ %s
  augroup END

"---[ Fugitive ]------------------------------------------------------
  cnoreabbrev <expr> gg getcmdtype() == ':' ? 'Ggrep' : 'gg'

"---[ GitGutter ]-----------------------------------------------------
  " Toggle GitGutter
  nnoremap <Leader>G :GitGutterToggle<CR>

"---[ HiLinks ]-------------------------------------------------------
  nnoremap <Leader>H :HLT!<CR>

"---[ Indent Guide ]--------------------------------------------------
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2

"---[ neocomplete ]---------------------------------------------------
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"---[ neosnippet ]----------------------------------------------------
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

"---[ NERDTree ]------------------------------------------------------
  nnoremap <Leader>N <Esc>:NERDTreeToggle<CR>
  let NERDTreeHijackNetrw = 0
  let NERDTreeShowHidden=1
  let NERDTreeIgnore=['\.git$', '\~$']

"---[ netrw ]---------------------------------------------------------
  nnoremap <Leader>E :Explore<CR>

"---[ Rainbow Parentheses ]-------------------------------------------
  let g:rainbow_active = 1

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

"---[ ALE ]-----------------------------------------------------------
  nmap <silent> <Leader>ll <Plug>(ale_lint)
  nmap <silent> <Leader>lp <Plug>(ale_previous_wrap)
  nmap <silent> <Leader>ln <Plug>(ale_next_wrap)
  let g:ale_echo_msg_info_str = 'I'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%:%severity%] %code%: %s'

  " Python
  let g:ale_python_pylint_executable = 'python'
  let g:ale_python_pylint_options = '-m pylint'
  let g:ale_python_flake8_executable = 'python'
  let g:ale_python_flake8_args = '-m flake8'

  function! PylintRC(where)
    let cfg = findfile('pylintrc', escape(a:where, ' ') . ';')
    return cfg !=# '' ? '-m pylint --rcfile=' . cfg : '-m pylint'
  endfunction

  autocmd FileType python let g:ale_python_pylint_options =
    \ PylintRC(expand('<afile>:p:h', 1))

  " HTML
  let g:ale_html_tidy_options = '--drop-empty-elements no'

"---[ Tabular ]-------------------------------------------------------
  nmap <silent> <Leader>t= :Tabularize /=<CR>
  vmap <silent> <Leader>t= :Tabularize /=<CR>
  nmap <silent> <Leader>t: :Tabularize /^[^:]*:\zs<CR>
  vmap <silent> <Leader>t: :Tabularize /^[^:]*:\zs<CR>

"---[ Tagbar ]--------------------------------------------------------
  nnoremap <Leader>T <Esc>:TagbarToggle<CR>

"---[ tmux-navigator ]------------------------------------------------

  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1

"---[ Undotree ]------------------------------------------------------
  nnoremap <Leader>U <Esc>:UndotreeToggle<CR>

"---[  vColor ]-------------------------------------------------------
  let g:vcoolor_lowercase = 1
  let g:vcoolor_disable_mappings = 1

"---[ Experiments ]--------------------------------------------------

function! GetFiletypes()
  let filetypes = []

  for rtp in split(&runtimepath, ",")
    let syntax_dir = rtp . "/syntax"
    if (isdirectory(syntax_dir))
      for syntax_file in split(glob(syntax_dir . "/*.vim"), "\n")
        call add(filetypes, fnamemodify(syntax_file, ":t:r"))
      endfor
    endif
  endfor

  return uniq(sort(filetypes))
endfunction
