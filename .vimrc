" my custom ViM configuration file

" Leader key - Default is "\"
" ---------------------------
"let mapleader="-"

" Enable Pathongen (default dir is .vim/bundle)
" ---------------------------------------------
execute pathogen#infect()
"execute pathogen#infect('stuff/{}')

" Set the automatic indention per file type  
" -----------------------------------------
filetype plugin indent on
"set autoindent

" Set modeline on and set the size where looking for the
" parameters from top or bottom es: /* vim: ft=cpp:...*/
" ------------------------------------------------------
set modeline
set modelines=5

" Enable the paste feature (No autoindent)
" <F12> For enable and disable the paste 
" ----------------------------------------
"set paste
"set pastetoggle=<F12> 
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>

" Set syntax highligth on
" -----------------------
:syntax on

" Set Comment color
" -----------------
"set background=dark
"highlight Comment ctermfg=grey

" Cursor position on status line
" ------------------------------
set ruler 

" Set status line color
" ---------------------
set laststatus=2 " Full status line 
au InsertEnter * hi StatusLine term=reverse ctermfg=red ctermbg=white
au InsertLeave * hi StatusLine term=reverse ctermfg=white ctermbg=red
"highlight StatusLine term=reverse ctermfg=red ctermbg=white
hi StatusLineNC term=reverse ctermfg=blue ctermbg=yellow

" Set Number color
" ----------------
set number
set numberwidth=3
highlight LineNr ctermfg=white ctermbg=black

" Set insert completion popup menu c-x + c-o
" ------------------------------------------
set pumheight=3

" Visualizing tabs
" ----------------
syntax match tab /\t/
hi tab gui=underline guifg=blue ctermbg=blue 

" Show command in the last line of the screen
" es. The leader key when pressed until the timeout left
" ------------------------------------------------------
set showcmd

" My command shortcuts
" Map for save a file with sudo privilege (sudo rules must exist)
" ---------------------------------------------------------------
noremap <Leader>W :w !sudo tee % > /dev/null

" VimCommander toggle
" -------------------
noremap <silent> <F2> :cal VimCommanderToggle()<CR> 

" EasyBuffer toggle
" -----------------
map <F3> :EasyBuffer<CR> 

" TagList toggle
" --------------
map <silent> <F4> :TlistToggle<CR> 

" TaskList toggle
" ---------------
nnoremap <leader>t <Plug>TaskList
map tl :TaskList<CR>

" NERDTree toggle
" ---------------
map <C-n> :NERDTreeToggle<CR>

" Gundo plugin
" ------------
"map g :GundoToggle<CR>

" #############################################
" Set default modeline (Python PEP 8 compliant)
" ---------------------------------------------
"set tabstop=8 " Default
"set softtabstop=4
"set shiftwidth=4
"set expandtab
"set textwidth=79
" #############################################

" Some modeline example
" ---------------------
" vi: ts=8 sw=4 sts=4 ai et
" vi: ts=8 sw=4 sts=4 ai et tw=79
" vim: tabstop=8:softtabstop=4:shiftwidth=4:expandtab:textwidth=79
" vim: tabstop=8:softtabstop=4:shiftwidth=4:expandtab 
" vim: tabstop=4:softtabstop=2:shiftwidth=2:expandtab

" N.B. Inserted five blank row otherwise vim will look for the modeline





