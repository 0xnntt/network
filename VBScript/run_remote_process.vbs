strComputer = "Computer" 
strDomain = "Domain" 
strUser = "username" 
strPassword = "Pass"
 
Set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")

Set objSWbemServices = objSWbemLocator.ConnectServer(strComputer, _
    "root\cimv2", _
     strUser, _
     strPassword, _
     "MS_409", _
     "ntlmdomain:" + strDomain)


Set colSwbemObjectSet = _
    objSWbemServices.ExecQuery("Select * From Win32_Process")
For Each objProcess in colSWbemObjectSet
    Wscript.Echo "Process Name: " & objProcess.Name 
Next
