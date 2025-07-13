" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

set mouse=a
set number
set incsearch
set hlsearch

if has('nvim')
	autocmd TermOpen * setlocal nonumber norelativenumber
endif

if !has('nvim')
    imap jk <Esc>
    imap kj <Esc>

    vmap kj <Esc>
    vmap jk <Esc>

    cmap kj <Esc>
    cmap jk <Esc>

    omap kj <Esc>
    omap jk <Esc>
endif

" otherwise it will leave a thick cursor in powershell
if has('win32')
    au VimLeave * set guicursor=a:ver1-blinkon1
endif

let g:mapleader = ","

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let g:python3_host_prog = 'py'

" length of an actual \t character:
set tabstop=4
" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=-1
" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0
" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
set expandtab

" reproduce the indentation of the previous line:
set autoindent
" keep indentation produced by 'autoindent' if leaving the line blank:
"set cpoptions+=I

" try to be smart (increase the indenting level after ‘{’,
" decrease it after ‘}’, and so on):
set smartindent

" a stricter alternative which works better for the C language:
"set cindent
" use language‐specific plugins for indenting (better):
filetype plugin indent on

let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

let g:mapleader = " "
nnoremap <leader>kc :call ToggleComment()<cr>
vnoremap <leader>kc :call ToggleComment()<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Go to tabs left and right
nnoremap H gT
nnoremap L gt

set path+=**

