" ============================================================================
" 1. Global LSP Settings
" ============================================================================

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_document_highlight_enabled = 0

highlight LspErrorHighlight       cterm=underline ctermfg=Red    gui=undercurl guisp=Red
highlight LspWarningHighlight     cterm=underline ctermfg=Yellow gui=undercurl guisp=Yellow
highlight LspInformationHighlight cterm=underline ctermfg=Cyan   gui=undercurl guisp=Cyan
highlight LspHintHighlight        cterm=underline ctermfg=Grey   gui=undercurl guisp=Grey

" ============================================================================
" 2. LSP Server Registration
" ============================================================================

function! s:get_root_uri(markers) abort
    let l:dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), a:markers)
    if empty(l:dir)
        let l:dir = expand('%:p:h')
    endif
    return lsp#utils#path_to_uri(l:dir)
endfunction

function! s:register_all_servers() abort
    " Typst (tinymist)
    if executable('tinymist')
        call lsp#register_server({
            \ 'name': 'tinymist',
            \ 'cmd': {server_info->['tinymist', 'lsp']},
            \ 'root_uri': {server_info->s:get_root_uri(['.git', 'main.typ'])},
            \ 'allowlist': ['typst'],
            \ 'initialization_options': {
            \   'preview': {
            \     'browsing': {
            \       'args': ['--no-open']
            \     }
            \   }
            \ }
            \ })
    endif

    " C / C++ (clangd)
    if executable('clangd')
        call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '--background-index']},
            \ 'root_uri': {server_info->s:get_root_uri(['compile_commands.json', '.clangd', '.git'])},
            \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
    endif

    " Python (pylsp)
    if executable('pylsp')
        call lsp#register_server({
            \ 'name': 'pylsp',
            \ 'cmd': {server_info->['pylsp']},
            \ 'root_uri': {server_info->s:get_root_uri(['pyproject.toml', 'setup.py', 'requirements.txt', '.git'])},
            \ 'allowlist': ['python'],
            \ })
    endif

    " SystemVerilog / Verilog (svlangserver + Verible)
    if executable('svlangserver')
        call lsp#register_server({
            \ 'name': 'svlangserver',
            \ 'cmd': {server_info->['svlangserver']},
            \ 'root_uri': {server_info->s:get_root_uri(['.svlangserver', '.git'])},
            \ 'allowlist': ['systemverilog', 'verilog'],
            \ 'workspace_config': {
            \   'systemverilog': {
            \     'includeIndexing': ['**/*.{sv,svh,v,vh}'],
            \     'excludeIndexing': ['test/**/*.sv*'],
            \     'defines': [],
            \     'launchConfiguration': 'verilator -sv --lint-only -Wall',
            \     'linter': 'verible',
            \     'formatCommand': 'verible-verilog-format',
            \   }
            \ }
            \ })
    endif
endfunction

if exists('g:lsp_loaded')
    call s:register_all_servers()
else
    augroup lsp_server_registrations
        autocmd!
        autocmd User lsp_setup call s:register_all_servers()
    augroup END
endif

" Re-check LSP attachment whenever a target filetype is set
augroup lsp_filetype_attach
    autocmd!
    autocmd FileType typst,c,cpp,objc,objcpp,python,systemverilog,verilog call lsp#enable()
augroup END

" ============================================================================
" 3. Buffer-Local LSP Keybinds
" ============================================================================

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Always bind diagnostics first
    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>d <plug>(lsp-document-diagnostics)

    " Pass each whitelisted server name explicitly to lsp#get_server_capabilities()
    if exists('*lsp#get_server_capabilities') && exists('*lsp#get_whitelisted_servers')
        for l:server in lsp#get_whitelisted_servers()
            let l:capabilities = lsp#get_server_capabilities(l:server)
            if !empty(l:capabilities)
                if get(l:capabilities, 'definitionProvider', v:false) isnot# v:false
                    nmap <buffer> gd <plug>(lsp-definition)
                endif
                if get(l:capabilities, 'referencesProvider', v:false) isnot# v:false
                    nmap <buffer> gr <plug>(lsp-references)
                endif
                if get(l:capabilities, 'hoverProvider', v:false) isnot# v:false
                    nmap <buffer> K <plug>(lsp-hover)
                endif
                if get(l:capabilities, 'renameProvider', v:false) isnot# v:false
                    nmap <buffer> <leader>rn <plug>(lsp-rename)
                endif
                if get(l:capabilities, 'codeActionProvider', v:false) isnot# v:false
                    nmap <buffer> <leader>ca <plug>(lsp-code-action)
                endif
                if get(l:capabilities, 'documentFormattingProvider', v:false) isnot# v:false
                    nmap <buffer> <leader>fm <plug>(lsp-document-format)
                endif
            endif
        endfor
    endif
endfunction

augroup lsp_buffer_binds
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================================
" 4. Typst Live Preview & Quickfix Toggle
" ============================================================================

function! s:TypstPreview() abort
    call lsp#send_request('tinymist', {
        \ 'method': 'workspace/executeCommand',
        \ 'params': {
        \   'command': 'tinymist.startDefaultPreview',
        \   'arguments': [
        \     '--data-plane-host=127.0.0.1:23625',
        \     '--control-plane-host=127.0.0.1:23626',
        \     '--no-open'
        \   ]
        \ }
        \ })
    echom 'Typst preview started on 127.0.0.1:23625'
endfunction

autocmd FileType typst command! -buffer TypstPreview call s:TypstPreview()

function! s:ToggleQuickfix() abort
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>q :call <SID>ToggleQuickfix()<CR>
