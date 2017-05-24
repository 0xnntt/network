$username = 'domain\username'
$password = 'password'

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential $username, $securePassword



function Get-LoggedOnUser {
#Requires -Version 2.0            
[CmdletBinding()]            
 Param             
   (                       
    [Parameter(Mandatory=$true,
               Position=0,                          
               ValueFromPipeline=$true,            
               ValueFromPipelineByPropertyName=$true)]            
    [String[]]$ComputerName
   )#End Param

Begin            
{            
 Write-Host "`n Checking Users . . . "
 $i = 0            
}#Begin          
Process            
{

    $alldata= New-Object PSObject -Property @{MachineName="";OS="";OSVersion="";Computer="";LoggedOn="";}
    $ComputerName | Foreach-object {
    $Computer = $_
    try
        {
            $processinfo = @(Get-WmiObject -class win32_process -ComputerName $Computer -EA "Stop" )
                if ($processinfo)
                {   $OSVersion = $processinfo[0].WindowsVersion
                    $OS = $processinfo[0].OSName
                    $Name = $processinfo[0].PSComputerName
                    $processinfo | Foreach-Object {$_.GetOwner().User} | 
                    Where-Object {$_ -ne "NETWORK SERVICE" -and $_ -ne "LOCAL SERVICE" -and $_ -ne "SYSTEM"} |
                    Sort-Object -Unique |
                    ForEach-Object {New-Object psobject -Property @{MachineName=$Name;OS=$OS;OSVersion=$OSVersion;Computer=$Computer;LoggedOn=$_;} } | 
                    Select-Object MachineName,OS,OSVersion,Computer,LoggedOn | Format-Table
                }#If
        }
    catch
        {
            "Cannot find any processes running on $computer" | Out-Host
        }
     }#Forech-object(ComputerName)       
            
}#Process
End
{

}#End

}#Get-LoggedOnUser
$servers = GC -Path "hosts.txt"
Get-LoggedOnUser -ComputerName $servers
