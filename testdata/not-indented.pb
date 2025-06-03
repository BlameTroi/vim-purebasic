; A small program to test indenting in Vim.

If Not OpenConsole("")
MessageRequester("ERROR", "Could not open console", #PB_MessageRequester_Ok)
End
EndIf

; Forward celar a module.

DeclareModule Ferrari
#FerrariName$ = "458 Italia"

Declare CreateFerrari()
EndDeclareModule

; Some lops and ifs.

PrintN("Some simple loops")
PrintN("")

Define i.i, j.i, k.i
Define r.i, s.i, t.i
Define x.f, y.f

Print("For/Next to sum 1 to 100 = ")

For i = 1 To 100
s = s + i
Next i
PrintN(Str(s))
PrintN("")

Print("While/Wend to halve sum until it is less than 4:")
While s > 3
Print(" " + Str(s) + ",")
s = s / 2
Wend
PrintN(" " + Str(s))
PrintN("")

PrintN("Generate some random numbers using Repeat/ForEver and a Break.")
Repeat
t = t + 1
If t > 20
Break
EndIf
r = Random(9, 0)
Select r
Case 1:
Print("One ")
Case 2:
Print("Two ")
Case 3:
Print("Three ")
Default:
Select r
Case 4:
Print("Four ")
Case 5:
Print("Five ")
Case 6, 7, 8:
If r = 6
Print("Six ")
ElseIf r = 7
Print("Seven ")
Else
Print("Eight ")
EndIf
Default:
Print(Str(r) + " ")
EndSelect
EndSelect
ForEver
PrintN("")
PrintN("")

; Some enumerations.

EnumerationBinary
#Flags1 ; will be 1
#Flags2 ; will be 2
#Flags3 ; will be 4
#Flags4 ; will be 8
#Flags5 ; will be 16
EndEnumeration

Enumeration 20 Step 3
#GadgetInfo ; will be 20
#GadgetText ; will be 23
#GadgetOK   ; will be 26
EndEnumeration

PrintN("Try accessing code in a module. There should be an init and three creates.")
UseModule Ferrari

CreateFerrari()
CreateFerrari()
CreateFerrari()

; Everything in here that wasn't mentioned in the DeclareModule should be
; private.

Module Ferrari

Global Initialized = #False

Procedure Init() ; Private init procedure
If Initialized = #False
Initialized = #True
PrintN("InitFerrari()")
EndIf
EndProcedure

Procedure CreateFerrari()
Init()
PrintN("CreateFerrari()")
EndProcedure

EndModule

Random(10)
; IDE Options = PureBasic 6.20 - C Backend (MacOS X - arm64)
; ExecutableFormat = Console
; CursorPosition = 120
; FirstLine = 97
; Folding = -
; EnableXP
; DPIAware
; Executable = indent-me
