function! s:getSyn(id) abort
  return printf('%s | %s',
    \ synIDattr(a:id, 'name'), synIDattr(synIDtrans(a:id), 'name'))
endfunction

function! synsational#Synstack(line, col) abort
  return map(synstack(a:line, a:col), 's:getSyn(v:val)')
endfunction
