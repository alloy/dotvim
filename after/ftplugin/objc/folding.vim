setlocal foldcolumn=3

function! ObjectiveCFolds()
  let line = getline(v:lnum)
  if match(line, '^@\(protocol\|interface\|implementation\)') >= 0
    return '>1'
  elseif match(line, '^#pragma mark') >= 0
    return '>1'
  elseif match(line, '^[-+]\s*(') >= 0
    " class or instance methods
    return '>2'
  else
    return '='
  endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=ObjectiveCFolds()

function! StripRight(string)
  return substitute(a:string, '\s\+$', '', '')
endfunction

function! ObjectiveCFoldText()
  let line = getline(v:foldstart)
  let list = matchlist(line, '^#pragma mark - \(.\+\)$')
  let desc = get(list, 1)
  if desc != '0'
    return '** ' . StripRight(desc) . ' ** '

  elseif match(line, '^[-+]\s*(') >= 0
    " get complete contents of method
    let text  = join(getline(v:foldstart, v:foldend), ' ')
    " remove everything after signature
    " TODO this can be optimized by only reading from foldstart upto these.
    let text  = substitute(text, '[;{].\+$', '', '')

    let space = '\s*'
    let type  = '(\%[\w\s]\+\*\?)'
    let arg   = type . space . '\w\+'

    " separate named parameters from the rest
    let list  = matchlist(text, '^' . space . '\([-+]\)' . space . type . space . '\(.\+\)')
    " * instance or class method
    let mtype = get(list, 1)
    " * remove arguments, leaving only parameters with colons
    let sel   = substitute(StripRight(get(list, 2)), arg . space, '', 'g')

    return ' ' . mtype . ' ' . sel . ' '
  else
    return StripRight(line) . ' '
  endif
endfunction
setlocal foldtext=ObjectiveCFoldText()

