$username = 'domain\username'
$password = 'pass'
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential $username, $securePassword
$all = New-Object PSObject 
function GetUser($hostname){
    
    $user = Get-WmiObject –ComputerName $hostname  –Class Win32_ComputerSystem -Credential  $cred 
    $user | Add-Member  -NotePropertyName IP -NotePropertyValue $hostname 
    
      $user | Select-Object  Name , IP, UserName ,Domain   | fl | out-string  >> "result.txt"

}
$servers = gc -Path ".\hosts.txt"
foreach($pc in $servers)
{
GetUser($pc)
}

#$all | Select-Object  Name , IP, UserName ,Domain   | Out-String
