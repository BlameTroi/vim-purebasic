" /vim-purebsic/ftdetect/purebasic.vim

" These are all the PureBasic filetypes I know of and their purpose.
"
" pb  -- standard source
" pbf -- from created with designer
" pbi -- looks to be include files
" pbl -- looks to be a parsed C include creating label value pairs
" pbp -- PureBasic project file
" sb  -- SpiderBasic, which for purposes of this pluging can be
"        treated as PureBasic
au BufNewFile,BufRead *.pb set filetype=purebasic
au BufNewFile,BufRead *.pbi set filetype=purebasic
au BufNewFile,BufRead *.pbf set filetype=purebasic
au BufNewFile,BufRead *.pbp set filetype=xml
au BufNewFile,BufRead *.sb set filetype=purebasic

" vim: ai:et:sw=4:ts=4
