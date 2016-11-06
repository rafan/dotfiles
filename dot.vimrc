"
" $Id: dot.vimrc 2949 2012-03-07 13:51:04Z rafan $
"
" If no screen, use color term
if ($TERM == "vt100")
	" xterm-color / screen
	set t_Co=8
	set t_AF=1%dm
	set t_AB=1%dm
else
if ($TERM == "xterm")
	set t_Co=256
endif
endif

" from kcwu
let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,korea,sjis,gb18030,latin1
set ambiwidth=double
"
" 右下角的地方看到現在在第幾行的第幾個字上面
set ruler
set autoindent
set smartindent
" 在 search 的時候可以把 search pattern 標明出來
set hls
set nocompatible
set secure
" shiftwidth
set sw=4
set tabstop=4
set expandtab
set smarttab
" set foldmethod=indent
set nowrap
set incsearch
set backspace=indent,eol,start	
set showmatch
set showcmd
set wildmenu
set previewheight=3
set updatetime=500
filetype indent on
filetype plugin on
set grepprg=grep\ -nH\ $*

" http://www.vim.org/tips/tip.php?tip_id=80
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

syntax on

highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7
" set background=light

" FreeBSD Doc Project
augroup sgmledit
  autocmd FileType sgml set formatoptions=cq2l " Special formatting options
  autocmd FileType sgml set textwidth=70       " Wrap lines at 70 columns
  autocmd FileType sgml set shiftwidth=2       " Automatically indent
  autocmd FileType sgml set softtabstop=2      " Tab key indents 2 spaces
  autocmd FileType sgml set tabstop=8          " Replace 8 spaces with a tab
  autocmd FileType sgml set autoindent         " Automatic indentation
augroup END


" Tips
" http://vim.sourceforge.net/tip_index.php
function Tip(enable,tip)
	let s:file=$HOME."/.vim/tips/".a:tip.".vim"
	if a:enable==1 && filereadable(s:file)
		exec "so ".s:file
	endif
endf
call Tip(0,102)" #102, smart mapping for tab completion
call Tip(1,277)" #277,
"let loaded_matchit=1

if version >= 700
  imap <C-z> <ESC>
  map  <C-c> :tabnew<CR>
  imap <C-c> <ESC>:tabnew<CR>
  map  <C-k> :tabclose<CR>
  map  <C-p> :tabprev<CR>
  imap <C-p> <ESC>:tabprev<CR>
  map  <C-n> :tabnext<CR>
  "imap <C-n> <ESC>:tabnext<CR>
  map <F4> :set invcursorline<CR>

  map g1 :tabn 1<CR>
  map g2 :tabn 2<CR>
  map g3 :tabn 3<CR>
  map g4 :tabn 4<CR>
  map g5 :tabn 5<CR>
  map g6 :tabn 6<CR>
  map g7 :tabn 7<CR>
  map g8 :tabn 8<CR>
  map g9 :tabn 9<CR>
  map g0 :tabn 10<CR>
  map gc :tabnew<CR>
  map gn :tabn<CR>
  map gp :tabp<CR>

  highlight TabLineSel term=bold,underline cterm=bold,underline ctermfg=7 ctermbg=0
  highlight TabLine    term=bold cterm=bold
  highlight clear TabLineFill

  au BufNewFile,BufRead *.txt,*.tex     set spell
  au BufNewFile,BufRead *.tex set expandtab sw=2 ts=2
  autocmd FileType mail setlocal spell spelllang=en

  " Crontabs must be edited in place
  au BufRead /tmp/crontab* :set backupcopy=yes

  au BufRead /tmp/cvs* setlocal spell spelllang=en

end

