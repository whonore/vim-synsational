function! s:maxLens(txt) abort
  let l:lens = []
  for l:idx in range(len(a:txt[0]) - 1)
    let l:lens = add(l:lens, [])
  endfor

  for l:line in a:txt
    let l:lens = map(l:lens, 'add(v:val, len(l:line[v:key]))')
  endfor
  return map(l:lens, 'max(v:val)')
endfunction

function! s:align(line, spaces, sep) abort
  let l:func = 'v:val . repeat(" ", get(a:spaces, v:key, 0) - len(v:val))'
  return join(map(a:line, l:func), a:sep)
endfunction

function! s:aligns(txt, sep) abort
  if a:txt == []
    return []
  endif
  let l:lens = s:maxLens(a:txt)
  return map(a:txt, 's:align(v:val, l:lens, a:sep)')
endfunction

function! s:getSyn(id) abort
  return [synIDattr(a:id, 'name'), synIDattr(synIDtrans(a:id), 'name')]
endfunction

function! synsational#Synstack(line, col) abort
  let l:syns = map(synstack(a:line, a:col), 's:getSyn(v:val)')
  return s:aligns(l:syns, ' | ')
endfunction
