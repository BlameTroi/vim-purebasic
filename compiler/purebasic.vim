" /vim-purebasic/ftplugin/purebasic/running.vim

" Almost everything in this directory is built upon the lessons in Steve
" Losh's _Learn Vim The Hard Way_. Even if you don't ever plan to use
" VimScript, I believe the book/website is worth checking out.
"
" This is a first attempt at build and run scripts. It doesn't do much
" useful and the run variety does not correctly launch the executable
" after the compilation.
"
" Environment variable PUREBASIC_HOME must be set, and your path should
" include "$PUREBASIC_HOME/compilers".
"
" g:PureBasic_Compiler        pbcompiler
" g:PUreBasic_Run_Options     -c -l -d -cl, comments and line numbers in for
"                              the debugger, console mode
" g:PureBasic_Compile_Options -c -l -cl, as above but no debug no launch
"                             creates output executable in cwd
" 
"
" TODO: Look at using make instead?
" TODO: More configuration options?
" TODO: Capture diagnostics for quickfix list. Jump locations.

"if exists("b:did_run")
"    finish
"endif
"
"let b:did_run = "purebasic"

if !exists("g:PureBasic_Compiler")
	let g:PureBasic_Compiler = "pbcompiler"
endif

if !exists("g:PureBasic_Run_Options")
	" commented, line nubered, console mode, debugger
	let g:PureBasic_Run_Options = "-c -l -cl -d"
endif

if !exists("g:PureBasic_Compile_Options")
	" commented line numbers console mode
	let g:PureBasic_Compile_Options = "-c -l -cl"
endif

function! PureBasicCompileAndRunFile()
	silent !clear
	execute "!" . g:PureBasic_Compiler . " " g:PureBasic_Run_Options . " " . bufname("%")
endfunction

function! PureBasicCompileFile()
	silent !clear
	execute "!" . g:PureBasic_Compiler . " " g:PureBasic_Compile_Options . " -o " . expand("%:r") . " " . bufname("%")
endfunction

" %:r for tail less extension, :e for extension only,
" :p full, :h last path component removed (path to file)

nnoremap <buffer> <localleader>rr :call PureBasicCompileAndRunFile()<cr>
nnoremap <buffer> <localleader>rc :call PureBasicCompileFile()<cr>

" vim: ai:et:ts=3:sw=3 
