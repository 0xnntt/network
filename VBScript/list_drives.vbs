strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colDisks = objWMIService.ExecQuery _
    ("Select * from Win32_LogicalDisk")
For Each objDisk in colDisks
    Wscript.Echo "DeviceID: "& vbTab _
        &  objDisk.DeviceID       
    Select Case objDisk.DriveType
        Case 1
            Wscript.Echo "No root directory. " _
                & "Drive type could not be " _
                & "determined."
        Case 2
            Wscript.Echo "DriveType: "& vbTab _
                &  "Removable drive."
        Case 3
            Wscript.Echo "DriveType: "& vbTab _
                &  "Local hard disk."
        Case 4
            Wscript.Echo "DriveType: "& vbTab _
                &  "Network disk."      
        Case 5
            Wscript.Echo "DriveType: "& vbTab _
                &  "Compact disk."      
        Case 6
            Wscript.Echo "DriveType: "& vbTab _
                &  "RAM disk."   
        Case Else
            Wscript.Echo "Drive type could not be" _
                & " determined."
    End Select
Next

