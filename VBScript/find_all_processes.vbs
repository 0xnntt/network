strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process")
For Each objProcess in colProcessList
    colProperties = objProcess.GetOwner( _
        strNameOfUser,strUserDomain)
    Wscript.Echo "Process " & objProcess.Name _
        & " is owned by " _ 
        & strUserDomain & "\" & strNameOfUser & "."
Next

