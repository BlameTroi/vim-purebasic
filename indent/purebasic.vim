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

"------------------------------------------------------------------------------
" ToDo:
"  Verify handling of multi-line exprs. and recovery upon the final ';'.
"  Correctly find comments given '"' and "" ==> " syntax.
"  Combine the two large block-indent functions into one?
"------------------------------------------------------------------------------

" Only load this indent file when no other was loaded.
if exists("b:did_indent") || version < 700
   finish
endif

let b:did_indent = 45

setlocal indentexpr=GetAdaIndent()
setlocal indentkeys-=0{,0}
setlocal indentkeys+=0=~then,0=~end,0=~elsif,0=~when,0=~exception,0=~begin,0=~is,0=~record

let b:undo_indent = "setl inde< indk<"

" Only define the functions once.
if exists("*GetAdaIndent")
   finish
endif
let s:keepcpo= &cpo
set cpo&vim

if exists("g:ada_with_gnat_project_files")
   let s:AdaBlockStart = '^\s*\(if\>\|while\>\|else\>\|elsif\>\|loop\>\|for\>.*\<\(loop\|use\)\>\|declare\>\|begin\>\|type\>.*\<is\>[^;]*$\|\(type\>.*\)\=\<record\>\|procedure\>\|function\>\|accept\>\|do\>\|task\>\|package\>\|project\>\|then\>\|when\>\|is\>\)'
else
   let s:AdaBlockStart = '^\s*\(if\>\|while\>\|else\>\|elsif\>\|loop\>\|for\>.*\<\(loop\|use\)\>\|declare\>\|begin\>\|type\>.*\<is\>[^;]*$\|\(type\>.*\)\=\<record\>\|procedure\>\|function\>\|accept\>\|do\>\|task\>\|package\>\|then\>\|when\>\|is\>\)'
endif

" Section: s:MainBlockIndent {{{1
"
" Try to find indent of the block we're in
" prev_indent = the previous line's indent
" prev_lnum   = previous line (to start looking on)
" blockstart  = expr. that indicates a possible start of this block
" stop_at     = if non-null, if a matching line is found, gives up!
" No recursive previous block analysis: simply look for a valid line
" with a lesser or equal indent than we currently (on prev_lnum) have.
" This shouldn't work as well as it appears to with lines that are currently
" nowhere near the correct indent (e.g., start of line)!
" Seems to work OK as it 'starts' with the indent of the /previous/ line.
function s:MainBlockIndent (prev_indent, prev_lnum, blockstart, stop_at)
   let lnum = a:prev_lnum
   let line = substitute( getline(lnum), g:ada#Comment, '', '' )
   while lnum > 1
      if a:stop_at != ''  &&  line =~ '^\s*' . a:stop_at  &&  indent(lnum) < a:prev_indent
	 return a:prev_indent
      elseif line =~ '^\s*' . a:blockstart
	 let ind = indent(lnum)
	 if ind < a:prev_indent
	    return ind
	 endif
      endif

      let lnum = prevnonblank(lnum - 1)
      " Get previous non-blank/non-comment-only line
      while 1
	 let line = substitute( getline(lnum), g:ada#Comment, '', '' )
	 if line !~ '^\s*$' && line !~ '^\s*#'
	    break
	 endif
	 let lnum = prevnonblank(lnum - 1)
	 if lnum <= 0
	    return a:prev_indent
	 endif
      endwhile
   endwhile
   " Fallback - just move back one
   return a:prev_indent - shiftwidth()
endfunction MainBlockIndent

" Section: s:EndBlockIndent {{{1
"
" Try to find indent of the block we're in (and about to complete),
" including handling of nested blocks. Works on the 'end' of a block.
" prev_indent = the previous line's indent
" prev_lnum   = previous line (to start looking on)
" blockstart  = expr. that indicates a possible start of this block
" blockend    = expr. that indicates a possible end of this block
function s:EndBlockIndent( prev_indent, prev_lnum, blockstart, blockend )
   let lnum = a:prev_lnum
   let line = getline(lnum)
   let ends = 0
   while lnum > 1
      if getline(lnum) =~ '^\s*' . a:blockstart
	 let ind = indent(lnum)
	 if ends <= 0
	    if ind < a:prev_indent
	       return ind
	    endif
	 else
	    let ends = ends - 1
	 endif
      elseif getline(lnum) =~ '^\s*' . a:blockend
	 let ends = ends + 1
      endif

      let lnum = prevnonblank(lnum - 1)
      " Get previous non-blank/non-comment-only line
      while 1
	 let line = getline(lnum)
	 let line = substitute( line, g:ada#Comment, '', '' )
	 if line !~ '^\s*$'
	    break
	 endif
	 let lnum = prevnonblank(lnum - 1)
	 if lnum <= 0
	    return a:prev_indent
	 endif
      endwhile
   endwhile
   " Fallback - just move back one
   return a:prev_indent - shiftwidth()
endfunction EndBlockIndent

" Section: s:StatementIndent {{{1
"
" Return indent of previous statement-start
" (after we've indented due to multi-line statements).
" This time, we start searching on the line *before* the one given (which is
" the end of a statement - we want the previous beginning).
function s:StatementIndent( current_indent, prev_lnum )
   let lnum  = a:prev_lnum
   while lnum > 0
      let prev_lnum = lnum
      let lnum = prevnonblank(lnum - 1)
      " Get previous non-blank/non-comment-only line
      while 1
	 let line = substitute( getline(lnum), g:ada#Comment, '', '' )

	 if line !~ '^\s*$' && line !~ '^\s*#'
	    break
	 endif
	 let lnum = prevnonblank(lnum - 1)
	 if lnum <= 0
	    return a:current_indent
	 endif
      endwhile
      " Leave indent alone if our ';' line is part of a ';'-delineated
      " aggregate (e.g., procedure args.) or first line after a block start.
      if line =~ s:AdaBlockStart || line =~ '(\s*$'
	 return a:current_indent
      endif
      if line !~ '[.=(]\s*$'
	 let ind = indent(prev_lnum)
	 if ind < a:current_indent
	    return ind
	 endif
      endif
   endwhile
   " Fallback - just use current one
   return a:current_indent
endfunction StatementIndent


" Section: GetAdaIndent {{{1
"
" Find correct indent of a new line based upon what went before
"
function GetAdaIndent()
   " Find a non-blank line above the current line.
   let lnum = prevnonblank(v:lnum - 1)
   let ind = indent(lnum)
   let package_line = 0

   " Get previous non-blank/non-comment-only/non-cpp line
   while 1
      let line = substitute( getline(lnum), g:ada#Comment, '', '' )
      if line !~ '^\s*$' && line !~ '^\s*#'
	 break
      endif
      let lnum = prevnonblank(lnum - 1)
      if lnum <= 0
	 return ind
      endif
   endwhile

   " Get default indent (from prev. line)
   let ind = indent(lnum)
   let initind = ind

   " Now check what's on the previous line
   if line =~ s:AdaBlockStart  ||  line =~ '(\s*$'
      " Check for false matches to AdaBlockStart
      let false_match = 0
      if line =~ '^\s*\(procedure\|function\|package\)\>.*\<is\s*new\>'
	 " Generic instantiation
	 let false_match = 1
      elseif line =~ ')\s*;\s*$'  ||  line =~ '^\([^(]*([^)]*)\)*[^(]*;\s*$'
	 " forward declaration
	 let false_match = 1
      endif
      " Move indent in
      if ! false_match
	 let ind = ind + shiftwidth()
      endif
   elseif line =~ '^\s*\(case\|exception\)\>'
      " Move indent in twice (next 'when' will move back)
      let ind = ind + 2 * shiftwidth()
   elseif line =~ '^\s*end\s*record\>'
      " Move indent back to tallying 'type' preceding the 'record'.
      " Allow indent to be equal to 'end record's.
      let ind = s:MainBlockIndent( ind+shiftwidth(), lnum, 'type\>', '' )
   elseif line =~ '\(^\s*new\>.*\)\@<!)\s*[;,]\s*$'
      " Revert to indent of line that started this parenthesis pair
      exe lnum
      exe 'normal! $F)%'
      if getline('.') =~ '^\s*('
	 " Dire layout - use previous indent (could check for g:ada#Comment here)
	 let ind = indent( prevnonblank( line('.')-1 ) )
      else
	 let ind = indent('.')
      endif
      exe v:lnum
   elseif line =~ '[.=(]\s*$'
      " A statement continuation - move in one
      let ind = ind + shiftwidth()
   elseif line =~ '^\s*new\>'
      " Multiple line generic instantiation ('package blah is\nnew thingy')
      let ind = s:StatementIndent( ind - shiftwidth(), lnum )
   elseif line =~ ';\s*$'
      " Statement end (but not 'end' ) - try to find current statement-start indent
      let ind = s:StatementIndent( ind, lnum )
   endif

   " Check for potential argument list on next line
   let continuation = (line =~ '[A-Za-z0-9_]\s*$')


   " Check current line; search for simplistic matching start-of-block
   let line = getline(v:lnum)
   if line =~ '^\s*#'
      " Start of line for ada-pp
      let ind = 0
   elseif continuation && line =~ '^\s*('
      " Don't do this if we've already indented due to the previous line
      if ind == initind
	 let ind = ind + shiftwidth()
      endif
   elseif line =~ '^\s*\(begin\|is\)\>'
      let ind = s:MainBlockIndent( ind, lnum, '\(procedure\|function\|declare\|package\|task\)\>', 'begin\>' )
   elseif line =~ '^\s*record\>'
      let ind = s:MainBlockIndent( ind, lnum, 'type\>\|for\>.*\<use\>', '' ) + shiftwidth()
   elseif line =~ '^\s*\(else\|elsif\)\>'
      let ind = s:MainBlockIndent( ind, lnum, 'if\>', '' )
   elseif line =~ '^\s*when\>'
      " Align 'when' one /in/ from matching block start
      let ind = s:MainBlockIndent( ind, lnum, '\(case\|exception\)\>', '' ) + shiftwidth()
   elseif line =~ '^\s*end\>\s*\<if\>'
      " End of if statements
      let ind = s:EndBlockIndent( ind, lnum, 'if\>', 'end\>\s*\<if\>' )
   elseif line =~ '^\s*end\>\s*\<loop\>'
      " End of loops
      let ind = s:EndBlockIndent( ind, lnum, '\(\(while\|for\)\>.*\)\?\<loop\>', 'end\>\s*\<loop\>' )
   elseif line =~ '^\s*end\>\s*\<record\>'
      " End of records
      let ind = s:EndBlockIndent( ind, lnum, '\(type\>.*\)\=\<record\>', 'end\>\s*\<record\>' )
   elseif line =~ '^\s*end\>\s*\<procedure\>'
      " End of procedures
      let ind = s:EndBlockIndent( ind, lnum, 'procedure\>.*\<is\>', 'end\>\s*\<procedure\>' )
   elseif line =~ '^\s*end\>\s*\<case\>'
      " End of case statement
      let ind = s:EndBlockIndent( ind, lnum, 'case\>.*\<is\>', 'end\>\s*\<case\>' )
   elseif line =~ '^\s*end\>'
      " General case for end
      let ind = s:MainBlockIndent( ind, lnum, '\(if\|while\|for\|loop\|accept\|begin\|record\|case\|exception\|package\)\>', '' )
   elseif line =~ '^\s*exception\>'
      let ind = s:MainBlockIndent( ind, lnum, 'begin\>', '' )
   elseif line =~ '^\s*then\>'
      let ind = s:MainBlockIndent( ind, lnum, 'if\>', '' )
   endif

   return ind
endfunction GetAdaIndent

let &cpo = s:keepcpo
unlet s:keepcpo

finish " 1}}}

"------------------------------------------------------------------------------
"   Copyright (C) 2006	Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=78 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
" endif
