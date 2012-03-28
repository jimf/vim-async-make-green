" AsynchronousMakeGreen
"   Asynchronously run make and display a red or green bar on success/failure
" Maintainer:   Jim Fitzpatrick
" Version:      0.0.2
" License:      MIT License

if exists('g:loaded_async_make_green')
    finish
endif
let g:loaded_async_make_green = 1

if !exists('g:async_make_green_success_prefix')
    let g:async_make_green_success_prefix = ' ✓ '
endif
if !exists('g:async_make_green_failure_prefix')
    let g:async_make_green_failure_prefix = ' ✖ '
endif
if !exists('g:async_make_green_default_success_text')
    let g:async_make_green_default_success_text = 'All tests passed'
endif
if !exists('g:async_make_green_use_make_output_on_success')
    let g:async_make_green_use_make_output_on_success = 0
endif

command! -nargs=* AsyncMakeGreen call s:AsyncMakeGreen(<q-args>)

function! s:AsyncMakeGreen(target)
    let make_cmd = &makeprg ." ". a:target
    call asynccommand#run(make_cmd, asynchandler_makegreen#quickfix_load(&errorformat))
endfunction
