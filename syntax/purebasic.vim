" Vim syntax file
" Language: PureBasic v6.20
" Maintainer: Thomas Knox
" Latest Revision: 06 Mar 2025

" Modified to fit my naming standards and to define syntax based folding.
" PureBasic seems amenable to syntax folding.

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "purebasic"

" Keywords
syntax keyword pureBasicLanguageKeywords Gosub Return FakeReturn Goto
syntax keyword pureBasicLanguageKeywords DataSection EndDataSection
syntax keyword pureBasicLanguageKeywords Data Restore Read
syntax keyword pureBasicLanguageKeywords Define Dim ReDimr Global
syntax keyword pureBasicLanguageKeywords Enumeration EnumerationBinary EndEnumeration
syntax keyword pureBasicLanguageKeywords Global NewList NewMap Protected
syntax keyword pureBasicLanguageKeywords Threaded Import
syntax keyword pureBasicLanguageKeywords VariableName FunctionName EndImport
syntax keyword pureBasicLanguageKeywords IncludeFile XIncludeFile IncludeBinary
syntax keyword pureBasicLanguageKeywords IncludePath Macro EndMacro
syntax keyword pureBasicLanguageKeywords UndefineMacro MacroExpandedCount
syntax keyword pureBasicLanguageKeywords DeclareModule EndDeclareModule
syntax keyword pureBasicLanguageKeywords Module EndModule
syntax keyword pureBasicLanguageKeywords UseModule UnUseModule
syntax keyword pureBasicLanguageKeywords End Swap Print PrintN With EndWith
syntax keyword pureBasicLanguageKeywords Interface EndInterface
syntax keyword pureBasicLanguageKeywords Str Chr
highlight link pureBasicLanguageKeywords Keyword

" PureBasic has Procedures and not Functions ...
syntax keyword pureBasicProcedure Procedure EndProcedure ProcedureReturn
highlight link pureBasicProcedure Function

" Conditionals
syntax keyword pureBasicConditional If ElseIf Else EndIf
syntax keyword pureBasicConditional Select Case Default EndSelect
highlight link pureBasicConditional Conditional

" Structures
syntax keyword pureBasicStructure Shared Static Structure Extends
syntax keyword pureBasicStructure Align EndStructure
syntax keyword pureBasicStructure StructureUnion EndStructureUnion
highlight link pureBasicStructure Structure

" Debugger
syntax keyword pureBasicDebug CallDebugger Debug DebugLevel
syntax keyword pureBasicDebug DisableDebugger EnableDebugger
highlight link pureBasicDebug Debug

" Data Types
syntax keyword pureBasicType Array List Map
syntax keyword pureBasicType Byte Ascii Character Word Unicode Long
syntax keyword pureBasicType Integer Float Quad Double String
highlight link pureBasicType Type

" Precompiler 
syntax keyword pureBasicPreCondit CompilerIf CompilerElseIf CompilerElse
syntax keyword pureBasicPreCondit CompilerEndIf CompilerSelect CompilerEndSelect
syntax keyword pureBasicPreCondit CompilerCase CompilerDefault
syntax keyword pureBasicPreCondit CompilerError CompilerWarning
syntax keyword pureBasicPreCondit EnableExplicit DisableExplicit
syntax keyword pureBasicPreCondit EnableASM DisableASM
syntax keyword pureBasicPreCondit SizeOf OffsetOf TypeOf Subsystem
syntax keyword pureBasicPreCondit Defined InitializeStructure CopyStructure
syntax keyword pureBasicPreCondit ClearStructure ResetStructure Bool
highlight link pureBasicPreCondit PreCondit

syntax match pureBasicConstant "\v#PB_(\a|_|\d)*"
highlight link pureBasicConstant Constant

syntax keyword pureBasicRepeat For ForEach To Step Next
syntax keyword pureBasicRepeat Repeat Until Forever
syntax keyword pureBasicRepeat While Wend
syntax keyword pureBasicRepeat Break Continue
highlight link pureBasicRepeat Repeat

syntax match pureBasicComment "\v\;.*$"
highlight link pureBasicComment Comment

syntax match pureBasicOperator "\v\*"
syntax match pureBasicOperator "\v/"
syntax match pureBasicOperator "\v\+"
syntax match pureBasicOperator "\v-"
syntax match pureBasicOperator "\v\%"
syntax match pureBasicOperator "\v\="
syntax match pureBasicOperator "\v\!"
syntax match pureBasicOperator "\v\&"
syntax match pureBasicOperator "\v\<"
syntax match pureBasicOperator "\v\>"
syntax match pureBasicOperator "\v\!\="
syntax match pureBasicOperator "\v\<\="
syntax match pureBasicOperator "\v\>\="
syntax match pureBasicOperator "\v\<\>"
syntax match pureBasicOperator "\v\|\|"
highlight link pureBasicOperator Operator

" Strings
" (TODO: single quotes?)
syntax region pureBasicString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link pureBasicString String

" Numeric Constants
" (TODO: scientific notation?)
syntax match pureBasicNumber "\v<\d+>"
syntax match pureBasicNumber "\v<\.\d+>"
syntax match pureBasicNumber "\v<\d+\.\d+>"
highlight link pureBasicNumber Number

" Syntax based folding for PureBasic.
"
" (The starting point for this was the writup at:
"  https://vim.fandom.com/wiki/Syntax_folding_of_Vim_scripts)
"
" Just about everything I would expect to be folded in PureBasic is cleanly
" wrapped in bracketing statements: Procedure/EndProcedure, For/Next,
" ForEach/Next, While/Wend and so on. The PureBasic IDE folds based on the
" major structure blocks (procedure, enumeration, module) but this should
" do those and a bit more. My only concerns are with things like if/else(if)/endif
" and select/case/default/endselect. Oh, and nesting of one structure inside
" itself (for ... for/next ... next).
"
" Fold markers must be the first non-blank word on a line. While the PureBasic
" IDE normalizes case for words (for->For, endmodule->EndModule) these checks
" are case insensitive.

" Define groups that cannot contain the start of a fold
syn cluster pureBasicNoFold contains=pureBasicComment,pureBasicString

" TODO: Review skip.

" Fold While ... Wend
syn region pureBasicFoldWhile
         \ start="\v\c^\s*while>"
         \ end="\v^\c\s*wend>"
         \ transparent fold
         \ keepend extend
         \ containedin=ALLBUT,@pureBasicNoFold
"skip+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+

" Fold For ForEach ... Next
" TODO: Better regexp.
syn region pureBasicFoldFor
         \ start="\v\c^\s*(for|foreach)>"
         \ end="\v^\c\s*next>"
         \ transparent fold
         \ keepend extend
         \ containedin=ALLBUT,@pureBasicNoFold
"skip+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+

" Fold Repeat ... Until ForEver
syn region pureBasicFoldRepeat
            \ start="\v\c^\s*repeat>"
            \ end="\v\c^\s*(until|forever)>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold DeclareModule ... EndDeclareModule
syn region pureBasicFoldDclModule
            \ start="\v\c^\s*declaremodule>"
            \ end="\v\c^\s*enddeclaremodule>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold Module ... EndModule
syn region pureBasicFoldModule
            \ start="\v\c^\s*module>"
            \ end="\v\c^\s*endmodule>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold Procedure ProcedureC ProcedureCDll ProcedureDll ... EndProcedure
" TODO: Better regexp.
syn region pureBasicFoldProcedure
            \ start="\v\c^\s*procedur(e|ec|ecdll|edll)>"
            \ end="\v\c^\s*endprocedure>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold CompilerIf ... CompilerEndIf
syn region pureBasicFoldCompilerIf
            \ start="\v\c^\s*compilerif>"
            \ end="\v\c^\s*compilerendif>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold EnableAsm ... DisableAsm
syn region pureBasicFoldEnableAsm
            \ start="\v\c^\s*<enableasm>"
            \ end="\v\c^\s*<disableasm>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold Macro ... EndMacro
syn region pureBasicFoldMacro
            \ start="\v\c^\s*macro>"
            \ end="\v\c^\s*endmacro>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold Select ... EndSelect
" NOTE: I'm explicitly NOT handling Case or Default. If you have enough code
" in a case to make folding desireable, you are doing it wrong.
syn region pureBasicFoldMacro
            \ start="\v\c^\s*select>"
            \ end="\v\c^\s*endselect>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold CompilerSelect ... CompilerEndSelect
" NOTE: I'm explicitly NOT handling Case or Default. If you have enough code
" in a case to make folding desireable, you are doing it wrong.
syn region pureBasicFoldMacro
            \ start="\v\c^\s*compilerselect>"
            \ end="\v\c^\s*endcompilerselect>"
            \ transparent fold
            \ keepend extend
            \ containedin=ALLBUT,@pureBasicNoFold

" Fold by PureBasic IDE markers ;{ ... ;}
syn region pureBasicFoldByMarker
         \ start="\v^\s*;\{"
         \ end="\v^\s*;\}"
         \ transparent fold
         \ keepend extend

" TODO: If/elseif/else/endif
"
" note that 'endif' has a shorthand which can also match many other end patterns
" if we did not include the word boundary \> pattern, and also it may match
" syntax end=/pattern/ elements, so we must explicitly exclude these
"syn region pureBasicFoldIfContainer
"      \ start="\<if\>"
"      \ end="\<en\%[dif]\>=\@!"
"      \ transparent
"      \ keepend extend
"      \ containedin=ALLBUT,@pureBasicNoFold
"      \ contains=NONE
"      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"syn region pureBasicFoldIf
"      \ start="\<if\>"
"      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
"      \ fold transparent
"      \ keepend
"      \ contained containedin=pureBasicFoldIfContainer
"      \ nextgroup=pureBasicFoldElseIf,pureBasicFoldElse
"      \ contains=TOP
"      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"syn region pureBasicFoldElseIf
"      \ start="\<else\%[if]\>"
"      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
"      \ fold transparent
"      \ keepend
"      \ contained containedin=pureBasicFoldIfContainer
"      \ nextgroup=pureBasicFoldElseIf,pureBasicFoldElse
"      \ contains=TOP
"      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"syn region pureBasicFoldElse
"      \ start="\<el\%[se]\>"
"      \ end="\<en\%[dif]\>=\@!"
"      \ fold transparent
"      \ keepend
"      \ contained containedin=pureBasicFoldIfContainer
"      \ contains=TOP
"      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+ "comment to fix highlight on wiki'
"
" vim: ai:et:sw=3:ts=3
