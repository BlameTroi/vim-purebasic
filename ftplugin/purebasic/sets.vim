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
" community standard.

let b:EditorConfig_disable=1
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

setlocal formatoptions-=t formatoptions+=croqla1
set comments=s:;
set commentstring=;\ %s

" vim: ai:et:ts=3:sw=3 
