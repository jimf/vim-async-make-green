if exists("g:loaded_autoload_asynccommand_makegreen") || &cp || !has('clientserver')
    finish
endif
let g:loaded_autoload_asynccommand_makegreen = 1

function! asynccommand_makegreen#first_error()
    let has_valid_error = 0
    for error in getqflist()
        if error['valid']
            let has_valid_error = 1
            break
        endif
    endfor
    if has_valid_error
        for error in getqflist()
            if error['valid']
                break
            endif
        endfor
        let error_message = g:async_make_green_failure_prefix . substitute(error['text'], '^ *', '', 'g')
        silent cc!
        exec ":sbuffer " . error['bufnr']
        call RedBar(error_message)
    else
        call GreenBar(g:async_make_green_success_prefix . g:async_make_green_default_success_text)
    endif
endfunction
