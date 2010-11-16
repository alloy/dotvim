" Vim syntax file
" Language:    Nu
" Maintainer:  Jeff Buck
" Last Change: 2009-12-10
" URL:	       http://github.com/itfrombit/nuvim.git
"
"  Parts derived from lisp.vim and ruby.vim
"
"  Add a line like this to your .vimrc file:
"  au BufNewFile,BufRead *.nu,*.nujson,Nukefile    setf nu



" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:current_syntax")
  finish
endif

setlocal iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_

if exists("g:nusyntax_ignorecase") || exists("g:nusyntax_cnu")
 set ignorecase
endif

" nush via screen hates tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" ---------------------------------------------------------------------
" Clusters: {{{1
syn cluster			nuAtomCluster		contains=nuAtomBarSymbol,nuAtomList,nuAtomNmbr0,nuComment,nuDecl,nuFunc,nuLeadWhite
syn cluster			nuBaseListCluster	contains=nuAtom,nuAtomBarSymbol,nuAtomMark,nuBQList,nuBarSymbol,nuComment,nuConcat,nuDecl,nuFunc,nuKey,nuList,nuNumber,nuSpecial,nuSymbol,nuVar,nuLeadWhite

if exists("g:nu_instring")
 syn cluster			nuListCluster		contains=@nuBaseListCluster,nuString,nuInString,nuInStringString
else
 syn cluster			nuListCluster		contains=@nuBaseListCluster,nuString
endif

syn case ignore

" ---------------------------------------------------------------------
" Lists: {{{1
syn match			nuSymbol			contained			![^()'`,"; \t]\+!
syn match			nuBarSymbol			contained			!|..\{-}|!
if exists("g:nu_rainbow") && g:nu_rainbow != 0
 syn region nuParen0           matchgroup=hlLevel0 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen1
 syn region nuParen1 contained matchgroup=hlLevel1 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen2
 syn region nuParen2 contained matchgroup=hlLevel2 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen3
 syn region nuParen3 contained matchgroup=hlLevel3 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen4
 syn region nuParen4 contained matchgroup=hlLevel4 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen5
 syn region nuParen5 contained matchgroup=hlLevel5 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen6
 syn region nuParen6 contained matchgroup=hlLevel6 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen7
 syn region nuParen7 contained matchgroup=hlLevel7 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen8
 syn region nuParen8 contained matchgroup=hlLevel8 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen9
 syn region nuParen9 contained matchgroup=hlLevel9 start="`\=(" end=")" skip="|.\{-}|" contains=@nuListCluster,nuParen0
else
 syn region nuList			matchgroup=Delimiter start="("   skip="|.\{-}|"			matchgroup=Delimiter end=")"	contains=@nuListCluster
 syn region nuBQList			matchgroup=PreProc   start="`("  skip="|.\{-}|"			matchgroup=PreProc   end=")"		contains=@nuListCluster
endif

" ---------------------------------------------------------------------
" Atoms: {{{1
syn match nuAtomMark			"'"
syn match nuAtom			"'("me=e-1			contains=nuAtomMark	nextgroup=nuAtomList
syn match nuAtom			"'[^ \t()]\+"			contains=nuAtomMark
syn match nuAtomBarSymbol		!'|..\{-}|!			contains=nuAtomMark
syn region nuAtom			start=+'"+			skip=+\\"+ end=+"+
syn region nuAtomList			contained			matchgroup=Special start="("	skip="|.\{-}|" matchgroup=Special end=")"	contains=@nuAtomCluster,nuString,nuSpecial
syn match nuAtomNmbr			contained			"\<\d\+"
syn match nuLeadWhite			contained			"^\s\+"

" ---------------------------------------------------------------------
" Standard Nu Functions and Macros: {{{1
syn keyword nuFunc		car
syn keyword nuFunc		cdr
syn keyword nuFunc		first
syn keyword nuFunc		rest
syn keyword nuFunc		head
syn keyword nuFunc		tail
syn keyword nuFunc		atom
syn keyword nuFunc		defined
syn keyword nuFunc		eq
syn keyword nuFunc		==
syn keyword nuFunc		!=
syn keyword nuFunc		cons
syn keyword nuFunc		append
syn keyword nuFunc		cond
syn keyword nuFunc		case
syn keyword nuFunc		if
syn keyword nuFunc		unless
syn keyword nuFunc		while
syn keyword nuFunc		until
syn keyword nuFunc		for
syn keyword nuFunc		break
syn keyword nuFunc		continue
syn keyword nuFunc		return
syn keyword nuFunc		try
syn keyword nuFunc		throw
syn keyword nuFunc		synchronized
syn keyword nuFunc		quote
syn keyword nuFunc		eval
syn keyword nuFunc		context
syn keyword nuFunc		set
syn keyword nuDecl		global
syn keyword nuFunc		regex
syn keyword nuDecl		def
syn keyword nuDecl		function
syn keyword nuFunc		progn
syn keyword nuFunc		then
syn keyword nuFunc		else
syn keyword nuDecl		macro-0
syn keyword nuDecl		macro-1
syn keyword nuDecl		macro
syn keyword nuFunc		macrox
syn keyword nuFunc		quasiquote
syn keyword nuFunc		quasiquote-eval
syn keyword nuFunc		quasiquote-splice
syn keyword nuFunc		+
syn keyword nuFunc		-
syn keyword nuFunc		*
syn keyword nuFunc		/
syn keyword nuFunc		**
syn keyword nuFunc		%
syn keyword nuFunc		&
syn keyword nuFunc		|
syn keyword nuFunc		>
syn keyword nuFunc		<
syn keyword nuFunc		>=
syn keyword nuFunc		<=
syn keyword nuFunc		<<
syn keyword nuFunc		>>
syn keyword nuFunc		and
syn keyword nuFunc		or
syn keyword nuFunc		not
syn keyword nuFunc		min
syn keyword nuFunc		max
syn keyword nuFunc		list
syn keyword nuDecl		do
syn keyword nuFunc		gets
syn keyword nuFunc		puts
syn keyword nuFunc		print
syn keyword nuFunc		let
syn keyword nuFunc		load
syn keyword nuFunc		beep
syn keyword nuFunc		uname
syn keyword nuFunc		system
syn keyword nuDecl		class
syn keyword nuDecl		is
syn keyword nuDecl		imethod
syn keyword nuDecl		cmethod
syn keyword nuDecl		ivar
syn keyword nuDecl		ivars
syn keyword nuDecl		ivar-accessors
syn keyword nuFunc		call
syn keyword nuFunc		send
syn keyword nuFunc		array
syn keyword nuFunc		dict
syn keyword nuFunc		parse
syn keyword nuFunc		help
syn keyword nuFunc		?
syn keyword nuFunc		version

syn keyword nuType		id
syn keyword nuType		void
syn keyword nuType		bool
syn keyword nuType		char
syn keyword nuType		int
syn keyword nuType		long
syn keyword nuType		float
syn keyword nuType		double

syn match   nuFunc		"\<c[ad]\+r\>"

" ---------------------------------------------------------------------
" Nu Keywords (modifiers): {{{1
syn keyword nuKey		each:
syn keyword nuKey		map:


" ---------------------------------------------------------------------
" Standard Nu Variables: {{{1
syn keyword nuVar		margs
syn keyword nuVar		*args

" ---------------------------------------------------------------------
" Strings: {{{1
syn region			nuString			start=+"+ skip=+\\\\\|\\"+ end=+"+	contains=nuInterpolation,nuInterpolationDelimiter
"if exists("g:nu_instring")
 syn region			nuInString			keepend matchgroup=Delimiter start=+"(+rs=s+1 skip=+|.\{-}|+ matchgroup=Delimiter end=+)"+ contains=@nuBaseListCluster,nuInStringString
 syn region			nuInStringString		start=+\\"+ skip=+\\\\+ end=+\\"+ contained
"endif

syn match nuStringEscape  "\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}"                           contained display
syn match nuStringEscape  "\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display


syn region nuInterpolation          matchgroup=nuInterpolationDelimiter start="#{" end="}" contained containedin=nuString contains=nuSpecial,@nuAtomListCluster
syn region nuNoInterpolation        start="\\#{" end="}"    contained


" ---------------------------------------------------------------------
" Numbers: supporting integers and floating point numbers {{{1
syn match nuNumber		"-\=\(\.\d\+\|\d\+\(\.\d*\)\=\)\(e[-+]\=\d\+\)\="

syn match nuSpecial		"\*\w[a-z_0-9-]*\*"
syn match nuSpecial		!#|[^()'`,"; \t]\+|#!
syn match nuSpecial		!#x\x\+!
syn match nuSpecial		!#o\o\+!
syn match nuSpecial		!#b[01]\+!
syn match nuSpecial		!#\\[ -}\~]!
syn match nuSpecial		!#[':][^()'`,"; \t]\+!
syn match nuSpecial		!#([^()'`,"; \t]\+)!
syn match nuSpecial		!#\\\%(Space\|Newline\|Tab\|Page\|Rubout\|Linefeed\|Return\|Backspace\)!
syn match nuSpecial		"\<+[a-zA-Z_][a-zA-Z_0-9-]*+\>"

syn match nuConcat		"\s\.\s"
syn match nuParenError	")"

" ---------------------------------------------------------------------
" Comments: {{{1
syn match   nuComment		";.*$"

" ---------------------------------------------------------------------
" Synchronization: {{{1
syn sync lines=100

" ---------------------------------------------------------------------
" Define Highlighting: {{{1

hi def link nuAtomNmbr					nuNumber
hi def link nuAtomMark					nuMark
hi def link nuInStringString			nuString
hi def link nuAtom						Identifier
hi def link nuAtomBarSymbol				Special
hi def link nuBarSymbol					Special
hi def link nuComment					Comment
hi def link nuConcat					Statement
hi def link nuDecl						Statement
hi def link nuFunc						Statement
hi def link nuKey						Type
hi def link nuMark						Delimiter
hi def link nuNumber					Number
hi def link nuParenError				Error
hi def link nuSpecial					Type
hi def link nuString					String
hi def link nuTodo						Todo
hi def link nuVar						Statement
hi def link nuType						Type
hi def link nuNoInterpolation			nuString
hi def link nuInterpolationDelimiter	nuDecl

if exists("g:nu_rainbow") && g:nu_rainbow != 0
 if &bg == "dark"
  hi def hlLevel0 ctermfg=red         guifg=red1
  hi def hlLevel1 ctermfg=yellow      guifg=orange1
  hi def hlLevel2 ctermfg=green       guifg=yellow1
  hi def hlLevel3 ctermfg=cyan        guifg=greenyellow
  hi def hlLevel4 ctermfg=magenta     guifg=green1
  hi def hlLevel5 ctermfg=red         guifg=springgreen1
  hi def hlLevel6 ctermfg=yellow      guifg=cyan1
  hi def hlLevel7 ctermfg=green       guifg=slateblue1
  hi def hlLevel8 ctermfg=cyan        guifg=magenta1
  hi def hlLevel9 ctermfg=magenta     guifg=purple1
 else
  hi def hlLevel0 ctermfg=red         guifg=red3
  hi def hlLevel1 ctermfg=darkyellow  guifg=orangered3
  hi def hlLevel2 ctermfg=darkgreen   guifg=orange2
  hi def hlLevel3 ctermfg=blue        guifg=yellow3
  hi def hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
  hi def hlLevel5 ctermfg=red         guifg=green4
  hi def hlLevel6 ctermfg=darkyellow  guifg=paleturquoise3
  hi def hlLevel7 ctermfg=darkgreen   guifg=deepskyblue4
  hi def hlLevel8 ctermfg=blue        guifg=darkslateblue
  hi def hlLevel9 ctermfg=darkmagenta guifg=darkviolet
 endif
endif


let b:current_syntax = "nu"

" ---------------------------------------------------------------------
" vim: ts=8 nowrap fdm=marker
