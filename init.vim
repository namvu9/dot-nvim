let g:ale_set_loclist = 0
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ale_set_quickfix = 1
let g:OmniSharp_diagnostic_exclude_paths = [
\ 'obj\\',
\ 'obj',
\ '[Tt]emp\\',
\ '\.nuget\\',
\ '\<AssemblyInfo\.cs\>'
\]

""============================================================ 
"" PLUGINS
""============================================================ 
call plug#begin('~/.vim/plugged')             

"" Essentials
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'
Plug 'OmniSharp/omnisharp-vim'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'w0rp/ale'

"" Color schemes
Plug 'joshdick/onedark.vim'

call plug#end()

"lua require('init')

""============================================================ 
"" GENERAL SETTINGS
""============================================================ 
set autoindent    " always set autoindenting on
set concealcursor=
set conceallevel=2
set copyindent    " copy the previous indentation on autoindenting
set expandtab
set foldlevelstart=20
set foldmethod=syntax
set hidden
set hlsearch          " highlight search terms
set ignorecase        " ignore case when searching
set inccommand=split
set incsearch         " show search matches as you type
set list lcs=tab:\|\  
set nobackup
set nocompatible
set noerrorbells         " dont beep
set nostartofline     " attempt to stay in the same column 
set noswapfile
set number relativenumber       " always show line numbers
set shiftround        " use multiple of shiftwidth when indenting with '<' and '>'
set shortmess+=c      " don't give |ins-completion-menu| messages.
set showmatch         " set show matching parenthesis
set signcolumn=yes    " always show signcolumns
set smartcase         " ignore case if search pattern is all lowercase, case-sensitive otherwise
set termguicolors
set textwidth=60
set title                " change the terminal'"s title
set updatetime=100    " Diagnostic messages perform poorly when using default (4000)
set visualbell           " don't beep
set wm=2
set wrap linebreak nolist
set background=dark

filetype plugin indent on       "show existing tab with 4 spaces width

colorscheme onedark
syntax on

hi Normal ctermbg=black guibg=black

""============================================================ 
"" FUNCTIONS
""============================================================ 
augroup neovim_terminal
  autocmd!
  "" Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  "" Disables number lines on terminal buffers
  autocmd TermOpen * :setlocal nonumber norelativenumber
  "" allows you to use Ctrl-c on terminal window
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

""============================================================ 
"" Autocommands
""============================================================ 
" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
	\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


""============================================================ 
"" KEYBOARD REMAPPINGS
""============================================================ 
let mapleader = ","
" Quickly reload/edit the vimrc file
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR> 
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap <silent> <leader><leader>qn :tabnew ~/Documents/wiki/quicknotes.md<CR>
nnoremap <silent> <leader><leader>td :tabnew ~/Documents/wiki/todo.md<CR>

" easymotion
map <leader><leader> <Plug>(easymotion-prefix)

function! Format()
  call CocActionAsync('format')
  if &ft =~ '\(css\|javascript\|html\|typescript\|typescript\.tsx\)'
   prettier
  else 
  endif
endfunction

nnoremap <Leader>f :call Format()<CR>

"" Search
nnoremap * *N
nnoremap <leader>? *:%s/<C-r>///g<left><left>

"" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window Management
nnoremap <C-Left> <C-w><
nnoremap <C-Right> <C-w>>
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-

" Move lines
nnoremap <M-k> :m -2<CR>
nnoremap <M-j> :m +1<CR>
vnoremap <M-k> :m -2<CR>gv=gv
vnoremap <M-j> :m +2<CR>gv=gv

" nerdtree
map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

" ctrlsf 
nnoremap <leader><S-f> :CtrlSF 

" inoremap 
inoremap <C-E> <End>
inoremap <C-A> <Home>
inoremap <leader><Esc> <C-o>$;<Esc>

" ============================================================
" Plugin config
" ============================================================
let ignore = [
  \ '.bloop',
  \ '.node_modules',
  \ 'DS_Store',
  \ '\.git',
  \ '.bloop',
  \ '.metals',
  \ 'Pods',
  \ 'ios',
  \ '.class',
  \ '_build',
  \ 'target',
  \ '.vscode',
  \ '.idea',
  \ 'android',
  \ '.venv',
  \ '.cache',
  \ '.dart_tool',
  \ 'testdata',
  \ 'vendor',
  \ 'dist-newstyle',
  \ 'build',
  \ 'obj'
\ ]

nnoremap <C-p> :CtrlP<CR>

"ctrlsf
let g:ctrlsf_ignore_dir = ['node_modules', 'ios', 'vendor', 'dist', '.cache']

""nerdtree
"let NERDTreeShowHidden=1
"" ============================================================
"" Other vimrc parts
"" ============================================================
source ~/.config/nvim/coc.vim

let g:ale_javascript_prettier_use_local_config = 1

"" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = { 'cs': ['OmniSharp'] }

let g:OmniSharp_server_use_net6 = 1 
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_selector_ui = 'fzf'


augroup omnisharp_commands
  autocmd!
  
  """ The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <S-k> <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  """ Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  """ Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader><space>d <Plug>(omnisharp_global_code_check)
  "" Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <space>ac <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <space>ac <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>f <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)
augroup END

autocmd FileType qf nmap <CR> <CR><c-w><c-p>
