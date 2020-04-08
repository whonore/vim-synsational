if exists('g:loaded_synsational')
  finish
endif
let g:loaded_synsational = 1

function! s:synsation() abort
  let [l:syn, l:hl] = synsational#Synstack(line('.'), col('.'))
  if l:syn == []
    return
  end

  if has('popupwin') && get(g:, 'synsational_mode', '') ==# 'popup'
    call popup_atcursor(l:syn, {'highlight': l:hl})
  else
    execute 'echohl ' . l:hl
    echo join(l:syn, "\n") | echohl None
  endif
endfunction

function! s:do_auto() abort
  if get(g:, 'synsational_auto', 0)
    augroup synsational
      autocmd! *
      autocmd CursorMoved * Synsation
    augroup END
  else
    silent! autocmd! synsational
    silent! augroup! synsational
  end
endfunction

call s:do_auto()

command! Synsation call <SID>synsation()
command! SynsationToggleAuto let g:synsational_auto = !get(g:, 'synsational_auto', 0) | call <SID>do_auto()

if get(g:, 'synsational_mapping', 1)
  nnoremap gss :Synsation<CR>
  nnoremap gst :SynsationToggleAuto<CR>
endif
