strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _ 
    & strComputer & "\root\cimv2") 
Set colComputer = objWMIService.ExecQuery _
    ("Select * from Win32_ComputerSystem")
 
For Each objComputer in colComputer
    Wscript.Echo "User Name = " & objComputer.UserName _
        & VBNewLine & "Computer Name = " & objComputer.Name
WScript.Echo objComputer.UserName
Next
