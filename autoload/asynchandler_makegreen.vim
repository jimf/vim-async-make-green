if exists("g:loaded_autoload_asynchandler_makegreen") || &cp || !has('clientserver')
    finish
endif
let g:loaded_autoload_asynchandler_makegreen = 1

function! asynchandler_makegreen#quickfix_load(format)
    let env = {
                \ 'command': "cgetfile",
                \ 'format': a:format,
                \ }
    function env.get(temp_file_name) dict
        let errorformat=&errorformat
        let &errorformat=self.format
        try
            let cmd = self.command . ' ' . a:temp_file_name
            exe cmd
            redraw!
            call asynccommand_makegreen#first_error()
            silent! wincmd p
        finally
            let &errorformat = errorformat
        endtry
    endfunction
    return asynccommand#tab_restore(env)
endfunction
