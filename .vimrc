" my custom ViM configuration file

" Leader key - Default is "\"
" ---------------------------
"let mapleader="-"

" Enable Pathongen (default dir is .vim/bundle)
" ---------------------------------------------
execute pathogen#infect()

" Set the automatic indention per file type  
" -----------------------------------------
filetype plugin indent on
"set autoindent

" Enable filetype plugins
" -----------------------
filetype plugin on

" Set modeline on and set the size where looking for the
" parameters from top or bottom es: /* vim: ft=cpp:...*/
" ------------------------------------------------------
set modeline
set modelines=5

" Enable the paste feature (No autoindent)
" <F12> For enable and disable the paste 
" ----------------------------------------
set paste
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>

" Show/Hide number feature
" <F11> For show/hide the number column
" ----------------------------------------
nnoremap <F11> :set invnumber number?<CR>
set pastetoggle=<F11>

" Set syntax highligth on
" -----------------------
:syntax on

" Set backgroud color
" -------------------
"set background=dark
set background=light

" Set Comment color
" -----------------
"highlight Comment ctermfg=grey

" Cursor position on status line
" ------------------------------
set ruler 

" Set status line color
" ---------------------
set laststatus=2 " Full status line 
au InsertEnter * hi StatusLine ctermfg=darkred ctermbg=black
au InsertLeave * hi StatusLine ctermfg=white ctermbg=black
"hi StatusLineNC ctermfg=lightblue
hi StatusLineNC ctermfg=DarkBlue

" Set Number color
" ----------------
set number
set numberwidth=3
highlight LineNr ctermfg=LightYellow ctermbg=black

" Set popup menu height (completion menu c-x + c-o)
" -------------------------------------------------
set pumheight=3

" Nice chars when set list is on
" ------------------------------
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\_,

" Visualizing tabs
" ----------------
syntax match tab /\t/
hi tab ctermfg=yellow ctermbg=red

" Visual selection color
" ----------------------
"hi Visual term=reverse
hi Visual ctermbg=white ctermfg=black

" Show command in the last line of the screen
" es. The leader key when pressed until the timeout left
" ------------------------------------------------------
set showcmd

" Folding
" -------
set foldmethod=indent
set foldlevel=99

" pyflakes
" --------
let g:pyflakes_use_quickfix = 0

" pep8
" ----
let g:pep8_map='<leader>8'

" Persistent undo/redo
set undofile
set undodir=~/.vim/undodir

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

" Modeline
" --------
" From http://vim.wikia.com/wiki/Modeline_magic
" Append modeline after last line in buffer.
" Example for set "noet" with printf
" printf(" vim: set %set :", &expandtab ? '' : 'no')
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d sts=%d tw=%d ff=%s ft=%s et ai :",
        \ &tabstop, &shiftwidth, &softtabstop, &textwidth, &fileformat, &filetype)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

function! PyAppendModeline()
  let l:pymodeline = printf("%s",
	\ '# vim: set ts=8 sw=4 sts=4 tw=79 ff=unix ft=python et ai :')
  call append(line("$"), l:pymodeline)
endfunction
nnoremap <silent> <Leader>pml :call PyAppendModeline()<CR>

" Some modeline example
" ---------------------
" # vi: ts=8 sw=4 sts=4 ai et tw=79
" # vim: set ts=8 sw=4 sts=4 ai et tw=79:
" # vim: tabstop=8:softtabstop=4:shiftwidth=4:expandtab:textwidth=79:autoindent

" N.B. Inserted five blank row otherwise vim will look for the above modeline





