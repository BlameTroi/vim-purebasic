" /vim-purebasic/ftplugin/purebasic/sets.vim

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
" IDE. These are different from my true preferences but I'll go with the
" community standard. Besides, if you load and then save a source file in
" the IDE, it gets re-indented anyway.

let b:EditorConfig_disable=1
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
" vim: ai:et:ts=3:sw=3 
