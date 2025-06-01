" /vim-purebsic/ftplugin/purebasic/sections.vim

" Almost everything in this directory is built upon the lessons in Steve
" Losh's _Learn Vim The Hard Way_. Even if you don't ever plan to use
" VimScript, I believe the book/website is worth checking out.

" no active code at this time
" 
" This is straight outta Losh again. I'm not using it yet since I haven't
" decided how I want to define a section in PureBasic. Major code blocks seem
" to begin with some easily recognizable 'Keyword...' and end with
" 'EndKeyword...'.
"
" This is incredibly sensible.
"
" The IDE editor lets you define section headers or some other boundary by a
" line starting with ';> -'".
"
"function! s:NextSection(type, backwards, visual)
"
"    if a:visual
"        " if called for visual, be sure to restore the visual
"        " selection.
"        normal! gv
"    endif
"
"    " type 1 is sections are delimited by blanks
"    " type 2 is by function headers
"
"    if a:type == 1
"        " line after a blank line with non-space first character
"        " or the first line of the file
"        let pattern = '\v(\n\n^\S|%^)'
"        let flags = 'e'
"    elseif a:type == 2
"        " a function header is a non-ws in first position, 
"        " possibly some more text then an equal sign, and
"        " again possibly more text, then a colon followed
"        " by the end of the line.
"        " -- book def has .*:$ at end???? --
"        let pattern = '\v^\S.*\=.*\:$'
"        " no flag needed
"        let flags = ''
"    endif
"
"    if a:backwards
"        let dir = '?'
"    else
"        let dir = '/'
"    endif
"
"    execute 'silent normal! ' . dir . pattern .dir . flags . "\r"
"
"endfunction
"
"" Normal mode movement.
"
"noremap <script> <buffer> <silent> ]]
"            \ :call <SID>NextSection(1, 0, 0)<cr>
"
"noremap <script> <buffer> <silent> [[
"            \ :call <SID>NextSection(1, 1, 0)<cr>
"
"noremap <script> <buffer> <silent> ][
"            \ :call <SID>NextSection(2, 0, 0)<cr>
"
"noremap <script> <buffer> <silent> []
"            \ :call <SID>NextSection(2, 1, 0)<cr>
"
"" Visual mode movement.
"
"vnoremap <script> <buffer> <silent> ]]
"            \ :call <SID>NextSection(1, 0, 1)<cr>
"
"vnoremap <script> <buffer> <silent> [[
"            \ :call <SID>NextSection(1, 1, 1)<cr>
"
"vnoremap <script> <buffer> <silent> ][
"            \ :call <SID>NextSection(2, 0, 1)<cr>
"
"vnoremap <script> <buffer> <silent> []
"            \ :call <SID>NextSection(2, 1, 1)<cr>
"
" vim: ai:et:ts=3:sw=3 
