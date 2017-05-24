strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process")
For Each objProcess in colProcessList
    Wscript.Echo "Process: " & objProcess.Name 
    Wscript.Echo "Process ID: " & objProcess.ProcessID 
    Wscript.Echo "Thread Count: " & objProcess.ThreadCount 
    Wscript.Echo "Page File Size: " _
        & objProcess.PageFileUsage 
    Wscript.Echo "Page Faults: " _
        & objProcess.PageFaults 
    Wscript.Echo "Working Set Size: " _
        & objProcess.WorkingSetSize 
Next
