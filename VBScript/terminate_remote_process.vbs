strComputer = "192.168.10.250" 
strDomain = "Domain" 
strUser = "UserName" 
strPassword = "Pass"
 
Set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")

Set objSWbemServices = objSWbemLocator.ConnectServer(strComputer, _
    "root\cimv2", _
     strUser, _
     strPassword, _
     "MS_409", _
     "ntlmdomain:" + strDomain)
Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where Name = 'Notepad.exe'")
For Each objProcess in colProcessList
    objProcess.Terminate()
Next
