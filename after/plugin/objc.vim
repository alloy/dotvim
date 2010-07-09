" Switch editing between
" *.c and *.h files  (C)
" or
" *.m and *.h files  (ObjC)
function! Flip_Extension()
 
  if match(expand("%"),'\.m') > 0
    let s:flipname = substitute(expand("%"),'\.m\(.*\)','.h\1',"")
    call LoadFile(s:flipname)
  elseif match(expand("%"),"\\.h") > 0
    let s:flipname = substitute(expand("%"),'\.h\(.*\)','.m\1',"")
    if (filereadable(s:flipname)) > 0
      call LoadFile(s:flipname)
    else
      let s:flipname = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
      call LoadFile(s:flipname)
    endif
  elseif match(expand("%"),"\\.c") > 0
    let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h\1',"")
    call LoadFile(s:flipname)
  endif
 
endfun
 
" Find the filename in an existing buffer
" if it exists open that buffer so you don't
" lose your file position.
function! LoadFile(filename)
  let s:bufname = bufname(a:filename)
  if (strlen(s:bufname)) > 0
    exe ":buffer" s:bufname
  else
    exe ":find " a:filename
  endif
endfun
 
map <F4> :call Flip_Extension()<CR>

