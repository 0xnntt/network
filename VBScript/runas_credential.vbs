strComputer = "ComputerRemote"
Set objSWbemLocator = CreateObject("WbemScripting.SWbemLocator")
Set objSWbemServices = objSWbemLocator.ConnectServer _
    (strComputer, "root\cimv2", _
    "domain\administrator", "password")
Set colProcessList = objSWbemServices.ExecQuery( _
    "Select * From Win32_Process")
For Each objProcess in colProcessList
    Wscript.Echo "Process Name: " & objProcess.Name 
Next
