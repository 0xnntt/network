strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
Set colQuickFixes = objWMIService.ExecQuery _
    ("Select * from Win32_QuickFixEngineering")
For Each objQuickFix in colQuickFixes
    Wscript.Echo "Description: " _
        & objQuickFix.Description
    Wscript.Echo "Hotfix ID: " & objQuickFix.HotFixID
Next

