strComputer = "." 
Set objWMIService = GetObject( _
    "winmgmts:\\" & strComputer & "\root\CIMV2") 
Set colItems = objWMIService.ExecQuery( _
    "SELECT * FROM Win32_Service",,48) 
For Each objItem in colItems 
    Wscript.Echo "Service Name: " & objItem.Name & VBNewLine _
        & "State: " & objItem.State
Next
