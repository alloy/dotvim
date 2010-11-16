" Nu plugin for vim
" Language:    Nu
" Maintainer:  Jeff Buck
" Last Change: 2010-04-23
" URL:         http://github.com/itfrombit/nuvim.git
"
" Description:
"
" This plugin has two main features:
"
" 1. Reformat/reindent Nu code from within Vim.
"
"    From anywhere in your Nu buffer, call
"    ReformatNu() (or type <C-c>n). You must
"    have nubile somewhere on your path.
"
" 2. Integrate Vim with nush using screen.
"
"    This allows you to interactively send parts
"    of your Nu buffer to a Nu shell via screen.
"
"    To set up screen, open a terminal window 
"    and run screen like this:
"		screen -S nush nush
"	 The '-S nush' argument names the screen
"	 session 'nush' (you can use whatever you like,
"	 or leave it blank as you'll be prompted for 
"	 the session name in Vim).  The final 'nush' 
"	 is the command to run in screen.
"
"    Then, in a separate terminal window, edit
"    your .nu file with Vim.  Put your cursor
"    somewhere in a block of Nu code (doesn't
"    matter where exactly) and type
"		<C-c><C-c>
"	 (That's "Control-C Control-C")
"
"	 The first time you do this you'll be
"	 prompted for the screen session name.
"	 Type the name you used above, or if you
"	 didn't supply a session, hit <TAB> and
"	 the default session name will be 
"	 auto-completed for you.  You will also
"	 be prompted for the window number, 
"	 which you can normally leave as the
"	 default "0".
"
"    The enclosing block of code out to the 
"    top-level will be selected and sent to 
"    the nush session and executed via screen.
"
"	 You can also enter Vim's visual mode and
"    manually highlight the code you want to 
"    send to screen.  The same <C-c><C-c>
"    keystrokes are used.  For example, to
"    send an entire Nu file to nush via 
"    screen, type:
"      ggVG<C-c><C-c>
"    and the whole file will be executed in
"    the nush session. Although, an easier
"    way to send an entire file is to use
"    the 
"		<C-c>f
"	 command mapping.
"
"    Other tips:
"    - You can have multiple Vim sessions
"      connected to the same screen session.
"
"    - You can change which screen session
"      a particular Vim session is connected
"      to by typing 
"	      <C-c>c
"      and you'll then be prompted for new
"      connection parameters.
"
"
" Acknowledgements:
"
" Thanks to Jonathan Palardy for inspiring the integration
" with screen.  He wrote about integrating Vim with Slime 
" in this blog post:
" http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/
" Some of the code below originated from that post.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saves the current cursor position, runs nubile on the
" buffer, and tries to restore the cursor position to
" where it was.

function ReformatNu()
  let currentPosition = getpos(".")
  exec ":1,$!nubile"
  call setpos(".", currentPosition)
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets up screen for interacting with nush (or whatever).
function SendToScreen(text)
  if !exists("g:screenSessionName") || !exists("g:screenWindowName") || g:screenSessionName == ""
    call ScreenConnect()
  end

  " tabs don't interact well with nush and the shell
  let detabbedText = substitute(a:text, "\t", "  ", "g")
  let escapedText = substitute(detabbedText, "'", "'\\\\''", 'g')

  echo system("screen -S " . g:screenSessionName . " -p " . g:screenWindowName . " -X stuff '" . escapedText . "'")
endfunction


function! ScreenSessionNames(ArgLead, CmdLine, CursorPos)
  return system("screen -ls | awk '/Attached/ {print $1}'")
endfunction


function ScreenConnect()
  if !exists("g:screenSessionName") || !exists("g:screenWindowName")
    let g:screenSessionName = "nush"
    let g:screenWindowName = "0"
  end

  let g:screenSessionName = input("Screen session name: ", "", "custom,ScreenSessionNames")
  let g:screenWindowName = input("Window name: ", g:screenWindowName)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If already in visual mode send buffer to screen
vmap <C-c><C-c> "ry :call SendToScreen(@r)<CR>

" If not in visual mode, enter and select the enclosing Nu 
" context, then run the above command.
nmap <C-c><C-c> vip<C-c><C-c>

nmap <C-c>f ggVG<C-c><C-c>
nmap <C-c>c :call ScreenConnect()<CR>
nmap <C-c>n :call ReformatNu()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

