# Script for collecting remote eventlogs (security)
# Author: 0xnnt and Google
# Date: Dec 2013
strDomain = "Domain" 
strUser = "UserName" 
strPassword = "Password"
strOutFolder = "C:\logs\"

Set colNamedArguments = WScript.Arguments.Named
strComputer = colNamedArguments.Item("c")
Set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")
Set objWMIService = objSWbemLocator.ConnectServer(strComputer, _
    "root\cimv2", _
     strUser, _
     strPassword, _
     "MS_409", _
     "ntlmdomain:" + strDomain)
Set colLogFiles = objWMIService.ExecQuery _
    ("Select * from Win32_NTEventLogFile " _
        & "Where LogFileName='Security'")
For Each objLogfile in colLogFiles
    errBackupLog = objLogFile.BackupEventLog( _
        strOutFolder+strComputer+".evtx")
    WScript.Echo "Security log from "+strComputer+"stored in "+ strOutFolder + "\\" +strComputer+".evt"
Next
