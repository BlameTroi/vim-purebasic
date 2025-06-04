; A small program to test folding in Vim.

If Not OpenConsole("")
  MessageRequester("ERROR", "Could not open console", #PB_MessageRequester_Ok)
  End
Else
  ; Forward declar a module.
  
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
    for j = i to s
      Print("?")
    next j
    If Mod(s,10) = 0
      Print(".")
    EndIf
  Next i

  PrintN(" " + Str(s))
  PrintN("")
  
  Print("While/Wend to halve sum until it is less than 4:")
  While s > 3
    Print(" " + Str(s) + ",")
    if #true
      for k = 7 to 10
        printn(str(k))
      next k
    endif
    s = s / 2
  Wend
  PrintN(" " + Str(s))
  PrintN("")
  
  ; Modulate.
  
  PrintN("Try accessing code in a module. There should be an init and three creates.")
  UseModule Ferrari
;{
  CreateFerrari()
  CreateFerrari()
  CreateFerrari()
;}
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
EndIf

; IDE Options = PureBasic 6.20 - C Backend (MacOS X - arm64)
; CursorPosition = 73
; FirstLine = 51
; Folding = -
; EnableXP
; DPIAware
