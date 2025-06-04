" /vim-purebsic/ftplugin/purebasic/folding.vim

" Almost everything in this directory is built upon the lessons in Steve
" Losh's _Learn Vim The Hard Way_. Even if you don't ever plan to use
" VimScript, I believe the book/website is worth checking out.

" I tried using foldmethod=indent but I didn't like it. I have the same
" objection to it that Losh describes in his chapter on advanced folding.
"
" His code from that chapter is a good starting point for a modified
" indent based folding. However, seeing how PureBasic brackets blocks
" very regularly with <word>/End<word I think syntax folding might work.

"if exists("b:did_fold")
"   finish
"endif
"
"let b:did_fold = "purebasic"
setlocal foldmethod=syntax
finish
" ----- commented out but retained if I need to bring this back to life
"" setlocal foldmethod=expr
"" setlocal foldexpr=g:PbGetFold(v:lnum)
"
"" Indent level is the number of spaces in the indent / shiftwidth.
"
"function! g:PbIndentLevel(lnum)
"   return indent(a:lnum) / &shiftwidth
"endfunction
"
"" Hunt for the next non-blank line or end of file.
"
"function! g:PbNextNonBlank(lnum)
"   let numlines = line('$')
"   let current = a:lnum + 1
"
"   while current <= numlines
"      if getline(current) =~? '\v\S'
"         return current
"      endif
"
"      let current += 1
"   endwhile
"
"   return -2
"endfunction
"
"" A fold includes the line that precedes an indented section.
"
"" TODO: outdents (next less than this) count as this if the first word is
"" one of else* end* case* default* or a comment.
"
"function! g:PbGetFold(lnum)
"
"   if getline(a:lnum) =~? '\v^\s*$'
"      return '-1'
"   endif
"
"   let lin_this = a:lnum
"   let ind_this = PbIndentLevel(lin_this)
"
"   " prevnonblank search starts AT argument.
"   let lin_prior = prevnonblank(lin_this - 1)
"   let ind_prior = g:PbIndentLevel(lin_prior)
"
"   " PbNextNonBlank search starts AFTER argument.
"   let lin_next = g:PbNextNonBlank(lin_this)
"   let ind_next = g:PbIndentLevel(lin_next)
"
"   if ind_this == ind_next
"      " Should I be checking for case/default/end*/else*/until/wend/forever?
"      return ind_this
"
"   elseif ind_this < ind_next
"      " Same question.
"      return ind_this
"
"   elseif ind_this > ind_next
"      " And again.
"      return ind_this
"      " return '>' . ind_next
"
"   endif
"
"endfunction

" vim: ai:et:ts=3:sw=3 
