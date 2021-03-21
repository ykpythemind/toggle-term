let s:save_cpo = &cpo
set cpo&vim

function! toggleterm#hide()
  let bufnum = get(t:, 'terminal_buffer', -1)
  if bufexists(bufnum)
    silent execute bufwinnr(bufnum) . "hide"
  endif
endfunction

function! toggleterm#toggle() abort
  if bufnr('') == get(t:, 'terminal_buffer', -1)
    call toggleterm#leave()
  else
    call toggleterm#enter()
  endif
endfunction

function! toggleterm#newterm()
  bot new
  exec 'resize ' . get(t:, 'switch_term_height', 20)
  call setbufvar(bufnr(''), '&buflisted', 0)
endfunction

function! toggleterm#enter()
  let l:tid = get(t:, 'toggle_terminal_id', -1)
  let t:previous_window_before_term = win_getid()

  if !win_gotoid(tid)
    " show hidden buffer
    if bufexists(get(t:, 'terminal_buffer', -1))
      call toggleterm#newterm()
      exec 'buffer ' . t:terminal_buffer
      startinsert
      let t:toggle_terminal_id = win_getid()
      return
    end

    " new term
    call toggleterm#newterm()
    term
    startinsert
    call setbufvar(bufnr(''), '&buflisted', 0)
    let t:terminal_buffer = bufnr('')
    let t:toggle_terminal_id = win_getid()
  endif
endfunction

function! toggleterm#leave()
  hide
  let prev = get(t:, 'previous_window_before_term', -1)
  call win_gotoid(prev)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
