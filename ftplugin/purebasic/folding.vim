" /vim-purebsic/ftplugin/purebasic/folding.vim

" Almost everything in this directory is built upon the lessons in Steve
" Losh's _Learn Vim The Hard Way_. Even if you don't ever plan to use
" VimScript, I believe the book/website is worth checking out.

" For initial testing I'll go with foldmethod indent, and if I don't like
" that I'll turn this code on and get it working. foldignore sets the
" indent of a line with a first nonblank character from those in foldignore
" to the surrounding lines. This only applies when foldmethod=indent.
"
" But also look ahead to sections on:
"
" - Fold/indent using the old ways.
" - A list of bracketing keywords that might be a better approach
"   than indent based folding.

setlocal foldmethod=indent
setlocal foldignore=;

" {{{ Old style folding indenting from Losh
"
" Fold/indent using the old ways:
"
" This currently commented out code is pretty much straight from Steve Losh's
" _Learn Vim the Hard Way_ chapters on building a filetype plugin for the
" potion language. I expect this will work ok with Purebasic but I need to
" account for block ends.
"
" This is Losh's folding code.
" All this code is basically here to make sure that the
" container lines around a block get folded with the
" block.
"setlocal foldmethod=expr
"setlocal foldexpr=GetPotionFold(v:lnum)
"
"function! IndentLevel(lnum)
"   return indent(a:lnum) / &shiftwidth
"endfunction
"
"function! NextNonBlankLine(lnum)
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
"function! GetPotionFold(lnum)
"   " Blank line.
"   if getline(a:lnum) =~? '\v^\s*$'
"      return '-1'
"   endif
"
"   let this_indent = IndentLevel(a:lnum)
"   let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
"
"   if next_indent == this_indent
"      " next line is the same as this, all is well
"      return this_indent
"   elseif next_indent < this_indent
"      " next line outdents, all is well
"      return this_indent
"   elseif next_indent > this_indent
"      " this line is a container of an indented block, so it
"      " should indent one step less than the next.
"      return '>' . next_indent
"   endif
"endfunction
"
" }}}

" {{{ Future Reference
"
" A list of bracketing keywords:
"
" This is followed are wonderfully explicit list of words and their impact on
" indenting or formatting. These are from purebasic.prefs as stored in
" ~/.purebasic/purebasic.prefs.
"
" {{{ Folding
"
" For folding it looks as if comments for folding are ;{ ;} as markers, but
" indenting and folding are also controlled by keywords.
"
" If I am reading this correctly, Start_1 is closed by End_1, etc., but at the
" tail where we see Start_7 through Start_10, all of those are closed by
" End_7.
"
"[Folding]
"EnableFolding = 1
"Start_1 = ;{
"Start_2 = CompilerIf
"Start_3 = DeclareModule
"Start_4 = EnableASM
"Start_5 = Macro
"Start_6 = Module
"Start_7 = Procedure
"Start_8 = ProcedureC
"Start_9 = ProcedureCDLL
"Start_10 = ProcedureDLL
"StartWords = 10
"End_1 = ;}
"End_2 = CompilerEndIf
"End_3 = DisableASM
"End_4 = EndDeclareModule
"End_5 = EndMacro
"End_6 = EndModule
"End_7 = EndProcedure
"EndWords = 7
" }}}
"
" {{{ Indenting
"
" While split in three separate variables, the layout is:
"
" keyword, indent before, indent after
"
" Values for before and after appear to say what to do with the line holding
" *this* value.
"
"[Indentation]
"IndentMode = 2
"BackspaceUnindent = 1
"NbKeywords = 51
"Keyword_0 = Case
"Before_0 = -1
"After_0 = 1
"Keyword_1 = CompilerCase
"Before_1 = -1
"After_1 = 1
"Keyword_2 = CompilerDefault
"Before_2 = -1
"After_2 = 1
"Keyword_3 = CompilerElse
"Before_3 = -1
"After_3 = 1
"Keyword_4 = CompilerElseIf
"Before_4 = -1
"After_4 = 1
"Keyword_5 = CompilerEndIf
"Before_5 = -1
"After_5 = 0
"Keyword_6 = CompilerEndSelect
"Before_6 = -2
"After_6 = 0
"Keyword_7 = CompilerIf
"Before_7 = 0
"After_7 = 1
"Keyword_8 = CompilerSelect
"Before_8 = 0
"After_8 = 2
"Keyword_9 = DataSection
"Before_9 = 0
"After_9 = 1
"Keyword_10 = DeclareModule
"Before_10 = 0
"After_10 = 1
"Keyword_11 = Default
"Before_11 = -1
"After_11 = 1
"Keyword_12 = Else
"Before_12 = -1
"After_12 = 1
"Keyword_13 = ElseIf
"Before_13 = -1
"After_13 = 1
"Keyword_14 = EndDataSection
"Before_14 = -1
"After_14 = 0
"Keyword_15 = EndDeclareModule
"Before_15 = -1
"After_15 = 0
"Keyword_16 = EndEnumeration
"Before_16 = -1
"After_16 = 0
"Keyword_17 = EndIf
"Before_17 = -1
"After_17 = 0
"Keyword_18 = EndImport
"Before_18 = -1
"After_18 = 0
"Keyword_19 = EndInterface
"Before_19 = -1
"After_19 = 0
"Keyword_20 = EndMacro
"Before_20 = -1
"After_20 = 0
"Keyword_21 = EndModule
"Before_21 = -1
"After_21 = 0
"Keyword_22 = EndProcedure
"Before_22 = -1
"After_22 = 0
"Keyword_23 = EndSelect
"Before_23 = -2
"After_23 = 0
"Keyword_24 = EndStructure
"Before_24 = -1
"After_24 = 0
"Keyword_25 = EndStructureUnion
"Before_25 = -1
"After_25 = 0
"Keyword_26 = EndWith
"Before_26 = -1
"After_26 = 0
"Keyword_27 = Enumeration
"Before_27 = 0
"After_27 = 1
"Keyword_28 = EnumerationBinary
"Before_28 = 0
"After_28 = 1
"Keyword_29 = For
"Before_29 = 0
"After_29 = 1
"Keyword_30 = ForEach
"Before_30 = 0
"After_30 = 1
"Keyword_31 = ForEver
"Before_31 = -1
"After_31 = 0
"Keyword_32 = If
"Before_32 = 0
"After_32 = 1
"Keyword_33 = Import
"Before_33 = 0
"After_33 = 1
"Keyword_34 = ImportC
"Before_34 = 0
"After_34 = 1
"Keyword_35 = Interface
"Before_35 = 0
"After_35 = 1
"Keyword_36 = Macro
"Before_36 = 0
"After_36 = 1
"Keyword_37 = Module
"Before_37 = 0
"After_37 = 1
"Keyword_38 = Next
"Before_38 = -1
"After_38 = 0
"Keyword_39 = Procedure
"Before_39 = 0
"After_39 = 1
"Keyword_40 = ProcedureC
"Before_40 = 0
"After_40 = 1
"Keyword_41 = ProcedureCDLL
"Before_41 = 0
"After_41 = 1
"Keyword_42 = ProcedureDLL
"Before_42 = 0
"After_42 = 1
"Keyword_43 = Repeat
"Before_43 = 0
"After_43 = 1
"Keyword_44 = Select
"Before_44 = 0
"After_44 = 2
"Keyword_45 = Structure
"Before_45 = 0
"After_45 = 1
"Keyword_46 = StructureUnion
"Before_46 = 0
"After_46 = 1
"Keyword_47 = Until
"Before_47 = -1
"After_47 = 0
"Keyword_48 = Wend
"Before_48 = -1
"After_48 = 0
"Keyword_49 = While
"Before_49 = 0
"After_49 = 1
"Keyword_50 = With
"Before_50 = 0
"After_50 = 1

" }}}
" vim: ai:et:ts=3:sw=3 
