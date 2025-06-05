"------------------------------------------------------------------------------
" /vim-purebsic/ftplugin/purebasic.vim
" Classic Vim support for PureBasic
"------------------------------------------------------------------------------
"
" Inspired by Steve Losh's _Learn Vim the Hard Way_ and with a pre-existing
" syntax file by Github user DNSGeek, I decided ot make a more functional
" filetype plugin for PureBasic.
"
" I'm using the format of the ada.vim ftplugin that ships with Vim as the
" shell for this plugin. It's well laid out and documented. I expect it will
" help me avoid missing bits of plugins that I am not familiar with.
"
" If you don't understand this, in addition to built in Vim :help and web
" searching, go work through Steve Losh's _Learn Vim the Hard Way_. Even if
" you don't ever plan to use VimScript, he explains the what and why of a
" classic Vim configuration. Neovim is somewhat different, but the basic shape
" is that of Vim.
"
" Features:
"
" - Regex based syntax highlighting.
"
" - Syntax based folding.
"
" - Vimscript based indenting.
"
" Still to do:
"
" - Compiler invocation.
"
" - Some sort of completion support, even if only keywords.
"
" - Normalize keyword casing to the PureBasic IDE standard (PascalCase).
"
" Limitations/Bugs/Antifeatures:
"
" - I make no attempt at backward compatability. Vim 8 was released in 2017.
"   It's now 2025.
"
" - If/EndIf folds do not consider Else/ElseIf. The fold is from the If to the
"   EndIf. I might revisit this if I find it to be a problem.
"
" - Select/EndSelect (and variants) do not consider Case/Default. The fold is
"   from the Select to the EndSelect.
"
"   People, if you have enough code in a Case to warrant folding, you are
"   doing it wrong. I will not revisit this.
"
"------------------------------------------------------------------------------
"
"------------------------------------------------------------------------------

" Only do this when not done yet for this buffer

if exists ("b:did_ftplugin")
   finish
endif

let b:did_ftplugin = "purebasic"

" Temporarily set cpoptions to ensure the script loads OK

let s:cpoptions = &cpoptions
set cpoptions-=C

" Section: Comments  {{{1

setlocal comments=;
setlocal commentstring=;\ %s\ 

" Section: case	     {{{1

setlocal nosmartcase
setlocal ignorecase

" Section: formatoptions {{{1

setlocal formatoptions-=t formatoptions+=croqla1

" Section indent/tabs {{{1

" Any settings for tab formating. I turn off EditorConfig via
" b:EditorConfig_Disable=1 here.
"
" NOTE:vim-sleuth and guess-indent users:
"
" Both of these plugins appear to apply editorconfig without regard to the
" value of b:EditorConfig_Disable.
"
" Also, the documentation in Vim/Neovim appears to be wrong. Setting
" b:editorconfig=0 does nothing that I can see, and EdotorConfig_disable was
" not mentioned. I found it be searching through configs on GitHub.
"
" These sw/ts/st/et options are meant to match the defaults of the PureBasic
" IDE.
" TODO: Move editorconfig disable out. This is a user level option.
let b:EditorConfig_disable=1

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Section: Tagging {{{1

" No tagging suppport at this time.

" Section: Completion {{{1

" Work in Progress.
" currenet buffer,buffers from other windows,other loaded buffers,other
" unloaded buffers
setlocal complete=.,w,b,u
" consider k, k{dict}, and maybe ] (tag completion)
" setlocal completefunc=ada#User_Complete
" setlocal omnifunc=adacomplete#Complete

" Section: Matchit {{{1

" Only do this when not done yet for this buffer & matchit is used
"
if !exists ("b:match_words")  &&
  \ exists ("loaded_matchit")
   "
   " The following lines enable the matchit.vim plugin for
   " PureBasic % jumping.
   " TODO: This is incomplete, I put just enough in here to test.
   let s:notend      = '\%(\<end\s\+\)\@<!'
   let b:match_words =
            \ s:notend . '\<if\>:\<elseif\>:\<else\>:\<endif\>,' .
            \ s:notend . '\<case\>:\<while\>:\<wend\>'
endif


" Section: Compiler {{{1

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
" TODO: Properly position.

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

if ! exists("current_compiler")			||
   \ current_compiler != g:PureBasic_Compiler
   execute "compiler " . g:PureBasic_Compiler
endif

" Section: Folding {{{1

setlocal foldmethod=syntax

" Section: Abbrev {{{1
"
if exists("g:ada_abbrev")
   " TODO: Do we need this? Probably not.
   iabbrev proc procedure
endif

" Section: Commands, Mapping, Menus {{{1

" NOTE:I don't think I need anything here.

" 1}}}
" Reset cpoptions
let &cpoptions = s:cpoptions
unlet s:cpoptions

finish " 1}}}

" vim: textwidth=78 nowrap tabstop=3 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
