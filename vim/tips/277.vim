
" Note:
" This is literally stolen from Vim help. The only changes are:
" (1) if w != ""               becomes       if w =~ "\k"
" (2) exe "silent! ptag " . w  becomes       exe "silent! psearch " . w
" * The first change prevents PreviewWord of searching while cursor is on some
"   non-keyword characters, e.g. braces, asterisks, etc.
function! PreviewWord()
  if &previewwindow " don't do this in the preview window
    return
  endif
  let w = expand("<cword>") " get the word under cursor
  if w =~ '\i'
    if w =~ '\<\v(for|while|if|else|continue|switch|return|break|case)\m\>'
      return
    endif
    if w =~ '\<\v(int|char|double|long|static|unsigned|const|void|extern|struct)\m\>'
      return
    endif
    if w =~ '\<\v(include|define|undef|ifdef|endif)\m\>'
      return
    endif
    " if there is one ":ptag" to it

    " Delete any existing highlight before showing another tag
    silent! wincmd P " jump to preview window
    if &previewwindow " if we really get there...
      match none " delete existing highlight
      wincmd p " back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    let v:errmsg = ""
    exe "silent! ptag " . w
    if v:errmsg =~ "tag not found"
      exe "silent! psearch " . w
    endif

    silent! wincmd P " jump to preview window
    if &previewwindow " if we really get there...
      if has("folding")
	silent! .foldopen " don't want a closed fold
      endif
      call search("$", "b") " to end of previous line
      let w = substitute(w, '\', '\\\', "")
      call search('\<\V' . w . '\>') " position cursor on match
      " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
      exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p " back to old window
    endif
  endif
endfunction

" Note:
" When you open a parenthesis after a function name, and at the
" line end, that function's definition is previewed through PreviewWord().
" This is inspired from Delphi's CodeInsight technology.
" Something similar (PreviewClassMembers) could be written for
" the C++ users, for previewing the class members when you type
" a dot after an object name.
" If somebody decides to write it, please, mail it to me.
function! PreviewFunctionSignature()
  let CharOnCursor = strpart( getline('.'), col('.')-2, 1)
  if col(".") == col("$")-1
    normal h
    call PreviewWord()
    normal l
  endif
endfunction

function Register(...)
  let index=1
  while index <= a:0
    execute 'let ext=a:'.index
    execute 'au! CursorHold '.ext.' nested call PreviewWord()'
    execute 'au BufNewFile,BufRead '.ext.' nested inoremap <buffer> ( <Esc>:call PreviewFunctionSignature()<CR>a('
    let index=index+1
  endwhile
endf
call Register('*.[ch]', '*.cc', '*.cpp')
call Register('*.[ch]0','*.cc0','*.cpp0')
