if exists('g:loaded_toggle_term')
  finish
endif
let g:loaded_toggle_term = 1

command! ToggleTerm call toggleterm#toggle()
command! HideTerm call toggleterm#hide()
