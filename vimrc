"---[ vimrc ]---------------------------------------------------------
" by: grant welch
"---[ notes ]---------------------------------------------------------
" Font: Liberation Mono for Powerline, 13pt
" Movement:
"   hjkl              " Move 1 char left,down,up,right
"   zz                " Center screen at cursor
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
"   :%s/pat/rep/g     " substitute every occurence of 'pat' with 'rep'
"   :%s/pattern//gn   " count matches, w/o replacement
"   :g/pattern/[cmd]  " run cmd on each line which matches the pattern
"                     " Ex: To delete all lines that contain "foobar".
"                     "   :g/foobar/normal dd
"   :v/pattern/[cmd]  " As above, but on lines that don't match pattern.
" Help:
"   $ vimtutor        " Open Vim's interactive instruction manual
"
"   :h[elp]           " main help file
"   :h user-manual    " user manual toc
"   :h reference_toc  " reference manual toc
"
"   Jumping Around:
"     C-]             " In help, follow a link.
"     C-O             "   ..., jump back to original position.
"
"   :h :<cmd>         " help with a specific command
"   :h topic|map      " help with a topic or a normal mapping
"   :h v_|i_|c_<map>  " help with a visual|insert|ex mapping
"   :h 'option'       " help with an option; e.g. :set option
"   :h netrw-quickmap " maps for netrw
" Misc:
"   ga                " Character info
"   :s/\v(.{120})/\1\r/g  " split long strings at 120th char

"---[ nocompatible ]--------------------------------------------------
  set nocompatible

"---[ plugins ]-------------------------------------------------------
" Install vim-plug:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Instructions:
"   :PlugInstall      - Install Plugs
"   :PlugUpdate       - Update Plugs
"   :PlugClean[!]     - Cleanup Plugs
"   :PlugUpgrade      - Upgrade vim-plug
"   :PlugUp           - (Custom) PlugUpgrade & PlugUpdate
"
" TODO: checkout these plugins:
"   ShowMarks
"   vdebug

if !filereadable(expand('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

call plug#begin('~/.vim/plugged')
  " airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " colors
  Plug 'vim-scripts/CSSMinister'
  Plug 'luochen1990/rainbow'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'ap/vim-css-color'
  Plug 'ilya-bobyr/vim-HiLinkTrace'

  " colorschemse
  Plug 'sanscore/badwolf'
  Plug 'tomasr/molokai'
  Plug 'NLKNguyen/papercolor-theme'

  " coding
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'Chiel92/vim-autoformat'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " python
  " Plug 'Vimjas/vim-python-pep8-indent'

  " ruby
  Plug 't9md/vim-ruby-xmpfilter'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-rbenv'
  Plug 'tpope/vim-bundler'

  " javascript
  Plug 'pangloss/vim-javascript'

  " tmux
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'sjl/vitality.vim'

  " vim
  Plug 'jlanzarotta/bufexplorer'
  Plug 'godlygeek/tabular'
  Plug 'majutsushi/tagbar'
  Plug 'mbbill/undotree'
  Plug 'embear/vim-localvimrc'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar'
  Plug 'nathanaelkane/vim-indent-guides'

  " lsp/completions/snippets
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
  if executable('ctags')
    Plug 'prabirshrestha/asyncomplete-tags.vim'
    Plug 'ludovicchabant/vim-gutentags'
  else
    echohl ErrorMsg
    echom '`ctags` is not installed:'
    echohl NONE
  endif

call plug#end()

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
  set nobackup
  set nowritebackup

"---[ undo ]----------------------------------------------------------
  if has("persistent_undo")
    if !isdirectory($HOME . "/tmp/vim/undo")
      silent! call mkdir($HOME . "/tmp/vim/undo", "p")
    endif
    set undodir=~/tmp/vim/undo/,~/tmp/
    set undofile
  endif

"---[ options ]-------------------------------------------------------
  set clipboard=
  set autoindent      " always set autoindenting on
  set autoread        " reread file if unchanged in vim and modified outside of vim
  set background=dark " dark background
  set belloff+=ctrlg  " Prevent beeping during autocomplete
  set colorcolumn=120 " add visual demarkation at 120 char
  set complete-=i     " don't scan the current & included files
  set complete-=k     " don't scan dict/words
  " set completeopt-=preview    " don't open preview window
  set completeopt+=menuone    " Popup when there's only one option
  set completeopt+=longest    " Only insert longest common match
  set completeopt+=noselect   " Don't select a menu item
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
  set noincsearch     " don't search while typing
  set iskeyword-=.    " . is never, _ever_ a keyword char
  set lazyredraw      " prevent redrawing while running macros, registers, and commands
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
  set shortmess+=c    " removes ins-completion-menu messages
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

  set cmdheight=2         " Additional area for commands
  set updatetime=300      " shorter delay for better experience
  set signcolumn=number   " merge signcolumn and number column

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
    set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline\ Bold\ 10
    " set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10
    " set guifont=DejaVu\ Sans\ Mono\ Regular
    set guioptions=c " use console dialogs
    set guioptions+=m " add menu bar
    set guioptions+=g " grey inactive menu items
    set guioptions+=t " include tearoff menu items
    set guioptions+=T " include Toolbar

    if &lines < 50
      set lines=50
      set columns=120
    endif

    " Copy/Paste as normal /shrug
    vmap <C-c> "+yi
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <C-r><C-o>+
  else
  endif

"---[ mappings ]------------------------------------------------------
  cnoremap %% <C-R>=expand('%:h').'/'<CR>

  " let j/k move through wrapped lines
  nnoremap j gj
  nnoremap k gk

  " make Y consistent with D and C; yank rest of line, not the whole line
  nnoremap Y y$

  " move highlight row to top of screen
  nnoremap n nzt
  nnoremap N Nzt
  nnoremap * *zt
  nnoremap # #zt
  xnoremap n nzt
  xnoremap N Nzt
  xnoremap * *zt
  xnoremap # #zt

  " disable help mapping
  nnoremap <F1> <nop>

  " disable Ex mode mappings
  nnoremap Q <nop>
  nnoremap gQ <nop>

  " disable cedit mappings
  noremap q: <nop>
  noremap q/ <nop>
  noremap q? <nop>

  " search for visually selected text
  vnoremap // y/<C-R>"<CR>

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
  nnoremap <Leader>gp "+p
  nnoremap <Leader>gP "+P
  " Visual Mode Del/Yank/Put
  vnoremap <Leader>gx "+d
  vnoremap <Leader>gy "+y
  vnoremap <Leader>gp "-d"+P

  " base64 encode/decode
  vnoremap <leader>64e c<c-r>=system('base64', @")<cr><esc>
  vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>

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

augroup myvimrc
  autocmd!
  autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif | :AirlineRefresh
augroup END

augroup clearbg
  autocmd!
  autocmd VimEnter,Colorscheme * :hi Normal ctermbg=none
  autocmd VimEnter,Colorscheme * :hi NonText ctermbg=none
  autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=52
  autocmd VimEnter,Colorscheme * :hi OverLength ctermbg=52 ctermfg=white guibg=#592929
  autocmd VimEnter,Colorscheme * call UpdateOverLength()
augroup END

fun! UpdateOverLength()
  setlocal colorcolumn=120
  match OverLength /\%120v.*/
endfun

augroup python
  autocmd!
  autocmd FileType python nnoremap <buffer> <silent> <Leader>pp ofrom pprint import pprint<esc>
  autocmd FileType python nnoremap <buffer> <silent> <Leader>pP Ofrom pprint import pprint<esc>
  autocmd FileType python nnoremap <buffer> <silent> <Leader>ps oimport pdb; pdb.set_trace()<esc>
  autocmd FileType python nnoremap <buffer> <silent> <Leader>pS Oimport pdb; pdb.set_trace()<esc>
  autocmd FileType python set colorcolumn=99
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
  command! PlugUp PlugUpgrade | PlugClean! | PlugUpdate

"---[ airline ]-------------------------------------------------------
  nnoremap <Leader>A <Esc>:AirlineToggle<CR>
  let g:airline_theme           = 'papercolor'
  let g:airline_powerline_fonts = 1
  " Allow one space after tabs for multiline comments /** */
  let g:airline#extensions#whitespace#mixed_indent_algo = 1

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
  cnoreabbrev <expr> gg getcmdtype() == ':' ? 'Git grep' : 'gg'

"---[ GitGutter ]-----------------------------------------------------
  " Toggle GitGutter
  nnoremap <Leader>G :GitGutterToggle<CR>

"---[ HiLinks ]-------------------------------------------------------
  nnoremap <Leader>H :HLT!<CR>

"---[ Indent Guide ]--------------------------------------------------
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2

"---[ asyncomplete ]--------------------------------------------------
  " imap <c-space> <Plug>(asyncomplete_force_refresh)

  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
    \ 'name': 'neosnippet',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
    \ }))

"---[ lsp (language server protocol) ]--------------------------------
	let g:lsp_diagnostics_enabled = 1
	let g:lsp_diagnostics_echo_cursor = 1

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " refer to doc to add more commands
  endfunction

  augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  let g:lsp_settings = {
  \ 'pyls': {
  \   'workspace_config': {
  \     'pyls': {
  \       'configurationSources': ['flake8'],
  \       'plugins': {
  \         'pydocstyle': {'enabled': v:true},
  \       }
  \     }
  \   }
  \ },
  \}

"---[ netrw ]---------------------------------------------------------
  nnoremap <Leader>E :15Lexplore<CR>
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  let g:netrw_winsize = 25
  let g:netrw_wiw = 15
  let g:netrw_hide = 1
  let g:netrw_list_hide = "tags"
  nmap <buffer> <silent> <nowait> <C-e> <Plug>NetrwRefresh

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

" remove underline highlighting
" highlight VisualNOS term=reverse ctermbg=242 guifg=#000000 guibg=#8787af
