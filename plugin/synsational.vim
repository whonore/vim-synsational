if exists('g:loaded_synsational')
  finish
endif
let g:loaded_synsational = 1

command! Synsation call popup_atcursor(synsational#Synstack(line('.'), col('.')), {})
