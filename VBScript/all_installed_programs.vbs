strComputer = "."


Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")



Set colSoftware = objWMIService.ExecQuery _
    ("Select * from Win32_Product")


For Each objSoftware in colSoftware
    Wscript.Echo "Name: " & objSoftware.Name
    Wscript.Echo "Version: " & objSoftware.Version
Next

