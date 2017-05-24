strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2") 
JobID = "Test"
Set objNewJob = objWMIService.Get("Win32_ScheduledJob")
errJobCreate = objNewJob.Create _
    ("Notepad.exe", "********143000.000000-420", _
        True , 1 OR 4 OR 16, ,True, JobId) 
If errJobCreate = 0 Then
    WScript.Echo "Job created successfully: " & VBNewLine _
        & "Notepad.exe scheduled to run repeately at 14.30 (2:30 P.M.) PST" & VBNewLine _
        & "on Mon, Wed, and Fri."
Else
    WScript.Echo "Job not created. Error code = " & errJobCreate
End If
