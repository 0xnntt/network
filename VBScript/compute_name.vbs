strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery _
    ("Select * from Win32_ComputerSystem")
For Each objItem in colItems
    Wscript.Echo "Computer Name: " & objItem.Name
Next
