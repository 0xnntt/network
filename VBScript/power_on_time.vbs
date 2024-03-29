strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery _
    ("Select * from Win32_OperatingSystem")
 
For Each objOS in colOperatingSystems
    dtmBootup = objOS.LastBootUpTime
    dtmLastBootUpTime = WMIDateStringToDate(dtmBootup)
    dtmSystemUptime = _
        DateDiff("h", dtmLastBootUpTime, Now)
    Wscript.Echo dtmSystemUptime 
Next
 
Function WMIDateStringToDate(dtmBootup)
    WMIDateStringToDate =  _
        CDate(Mid(dtmBootup, 5, 2) & "/" & _
        Mid(dtmBootup, 7, 2) & "/" & Left(dtmBootup, 4) _
        & " " & Mid (dtmBootup, 9, 2) & ":" & _
        Mid(dtmBootup, 11, 2) & ":" & Mid(dtmBootup, _
        13, 2))
End Function

