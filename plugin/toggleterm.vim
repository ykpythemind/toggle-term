let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_toggle_term')
  finish
endif
let g:loaded_toggle_term = 1

command! ToggleTerm call toggleterm#toggle()
command! HideTerm call toggleterm#hide()

let &cpo = s:save_cpo
unlet s:save_cpo
