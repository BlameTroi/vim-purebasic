" Create a dictionary keyed by PureBasic keywords with each entry holding
if exists("b:did_work")
    finish
endif

let b:did_work = "purebasic"

finish

" (so far) a list of [indent_before, indent_after]
let s:pb_indents = {
\ 'Case':[-1, 1],
\ 'CompilerCase':[-1, 1],
\ 'CompilerDefault':[-1, 1],
\ 'CompilerElse':[-1, 1],
\ 'CompilerElseIf':[-1, 1],
\ 'CompilerEndIf':[-1, 0],
\ 'CompilerEndSelect':[-2, 0],
\ 'CompilerIf':[0, 1],
\ 'CompilerSelect':[0, 2],
\ 'DataSection':[0, 1],
\ 'DeclareModule':[0, 1],
\ 'Default':[-1, 1],
\ 'Else':[-1, 1],
\ 'ElseIf':[-1, 1],
\ 'EndDataSection':[-1, 0],
\ 'EndDeclareModule':[-1, 0],
\ 'EndEnumeration':[-1, 0],
\ 'EndIf':[-1, 0],
\ 'EndImport':[-1, 0],
\ 'EndInterface':[-1, 0],
\ 'EndMacro':[-1, 0],
\ 'EndModule':[-1, 0],
\ 'EndProcedure':[-1, 0],
\ 'EndSelect':[-2, 0],
\ 'EndStructure':[-1, 0],
\ 'EndStructureUnion':[-1, 0],
\ 'EndWith':[-1, 0],
\ 'Enumeration':[0, 1],
\ 'EnumerationBinary':[0, 1],
\ 'For':[0, 1],
\ 'ForEach':[0, 1],
\ 'ForEver':[-1, 0],
\ 'If':[0, 1],
\ 'Import':[0, 1],
\ 'ImportC':[0, 1],
\ 'Interface':[0, 1],
\ 'Macro':[0, 1],
\ 'Module':[0, 1],
\ 'Next':[-1, 0],
\ 'Procedure':[0, 1],
\ 'ProcedureC':[0, 1],
\ 'ProcedureCDLL':[0, 1],
\ 'ProcedureDLL':[0, 1],
\ 'Repeat':[0, 1],
\ 'Select':[0, 2],
\ 'Structure':[0, 1],
\ 'StructureUnion':[0, 1],
\ 'Until':[-1, 0],
\ 'Wend':[-1, 0],
\ 'While':[0, 1],
\ 'With':[0, 1],
\ }

