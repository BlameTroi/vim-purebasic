" /vim-purebasic/indent/purebasic.vim

" Vim indent file
"
" This is for PureBasic (ft=purebasic) and it might work OK for
" SpiderBasic. I'm using the standard /nvim/runtime/indent/vb.vim
" as a starting point. The version I started from shows its last
" maintenance date as 2022/12/26.
"
" PureBasic is very regular so hopefully this will be a smooth
" operation.
" TODO: switch from g: to s: once debugged.
" TODO: fix indenting for select/case/case/endselect.
" TODO: this is very rough
"if exists("b:did_indent")
"   finish
"endif
"let b:did_indent = 1

setlocal noautoindent
finish
setlocal indentexpr=g:PbGetIndent(v:lnum)
" TODO: should indent keys be empty? NO. Or maybe everything in pb_indents?
" setlocal indentkeys&
setlocal indentkeys==~else,=~elseif,=~endif,=~wend,=~case,=~next,=~select,=~loop,=~while
setlocal indentkeys+==~for,=~foreach,=~forever,=~procedure,=~endprocedure,=~repeat,=~until

let b:undo_indent = "set ai< indentexpr< indentkeys<"

" if !exists("g:PbIndents")

" Create a dictionary keyed by PureBasic keywords with each entry holding
" (so far) a list of [indent_before, indent_after].
"
" Unfortunately, list and dictionary looks are case sensitive even when I
" have ignorecase on. Rather than loop myself doing a case insensitive match
" I'll just convert indent word entries to lowercase and search for them
" by lowercase as well.
"
" Each word is a boundary for indenting. The PureBasic IDE will change
" any word to its preferred case. PureBasic is case insensitive. In my
" research I haven't found any keyword that resets indent to column 0.
"
" Put no word in this list that has a [indent_before, indent_after] of
" [0, 0]. That is a special value.

let g:PbIndents = {
         \ 'case':[-1, 1],
         \ 'compilercase':[-1, 1],
         \ 'compilerdefault':[-1, 1],
         \ 'compilerelse':[-1, 1],
         \ 'compilerelseif':[-1, 1],
         \ 'compilerendif':[-1, 0],
         \ 'compilerendselect':[-2, 0],
         \ 'compilerif':[0, 1],
         \ 'compilerselect':[0, 2],
         \ 'datasection':[0, 1],
         \ 'declaremodule':[0, 1],
         \ 'default':[-1, 1],
         \ 'else':[-1, 1],
         \ 'elseif':[-1, 1],
         \ 'enddatasection':[-1, 0],
         \ 'enddeclaremodule':[-1, 0],
         \ 'endenumeration':[-1, 0],
         \ 'endif':[-1, 0],
         \ 'endimport':[-1, 0],
         \ 'endinterface':[-1, 0],
         \ 'endmacro':[-1, 0],
         \ 'endmodule':[-1, 0],
         \ 'endprocedure':[-1, 0],
         \ 'endselect':[-2, 0],
         \ 'endstructure':[-1, 0],
         \ 'endstructureunion':[-1, 0],
         \ 'endwith':[-1, 0],
         \ 'enumeration':[0, 1],
         \ 'enumerationbinary':[0, 1],
         \ 'for':[0, 1],
         \ 'foreach':[0, 1],
         \ 'forever':[-1, 0],
         \ 'if':[0, 1],
         \ 'import':[0, 1],
         \ 'importc':[0, 1],
         \ 'interface':[0, 1],
         \ 'macro':[0, 1],
         \ 'module':[0, 1],
         \ 'next':[-1, 0],
         \ 'procedure':[0, 1],
         \ 'procedurec':[0, 1],
         \ 'procedurecdll':[0, 1],
         \ 'proceduredll':[0, 1],
         \ 'repeat':[0, 1],
         \ 'select':[0, 2],
         \ 'structure':[0, 1],
         \ 'structureunion':[0, 1],
         \ 'until':[-1, 0],
         \ 'wend':[-1, 0],
         \ 'while':[0, 1],
         \ 'with':[0, 1],
         \ }
" echom g:PbIndents

" What should be done, if anything, before this line. So 'Wend':[-1, 0] should
" outdent this line one shiftwidth from the prior non-blank line.

function! g:PbBefore(lnum)
   "echom "before " . a:lnum . ":" . line(a:lnum)
   if getline(a:lnum) =~ "^\s*$"
      return '0'
   endif
   let fwd = tolower(split(getline(a:lnum))[0])
   "echom "seeking before of " . fwd
   let bef = get(g:PbIndents, fwd, [0,0])[0]
   "echom "returning " . bef
   return "" . bef
endfunction

" What should be done, if anything, after this line. So 'Wend':[-1, 0] means
" that the line following Wend likely has the same indent as Wend.

function! g:PbAfter(lnum)
   " echom "after " . a:lnum . ":" . line(a:lnum)
   if getline(a:lnum) =~ "^\s*$"
      return '0'
   endif
   let fwd = tolower(split(getline(a:lnum))[0])
   "echom "seeking after of " . fwd
   let aft = get(g:PbIndents, fwd, [0,0])[1]
   "echom "returning " . aft
   return "" . aft
endfunction

" endif

" Only define this function once.

" if !exists("*g:PbGetIndent")

function! g:PbGetIndent(lnum)
   let this_lnum = a:lnum
   let this_line = getline(this_lnum)

   " Get the current value of "shiftwidth"

   let bShiftwidth = shiftwidth()

   " Find a non-blank line above the current line. The assumption is that
   " the prior line is properly indented.

   let lnum = this_lnum
   let lnum = prevnonblank(lnum - 1)

   " Hit the start of the file, use zero indent.

   if lnum == 0
      return 0
   endif

   let pri_aft = g:PbAfter(lnum)
   let pri_bef = g:PbBefore(lnum)
   let pri_spcl = pri_aft != 0 || pri_bef != 0

   let this_aft = g:PbAfter(this_lnum)
   let this_bef = g:PbBefore(this_lnum)
   let this_spcl = this_aft != 0 || this_bef != 0

   if pri_aft != 0 && this_bef != 0
      echom "ERROR in indent def for " . line(this_lnum)
      return -1
   endif

   if pri_aft != 0
      return indent(lnum) + (bShiftwidth * pri_aft)
   elseif this_bef != 0
      return indent(lnum) + (bShiftwidth * this_bef)
   else
      return indent(lnum)
   endif
endfunction

" endif
