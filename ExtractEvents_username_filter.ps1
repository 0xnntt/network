# Author : 0xnnt 
# Date: April 2015
# this little script will extract specific eventlog entries with username filter ( multiple username & eventlog.evtx files can be selected )

$output = "E:\parsed_logs\"
$folder = "C:\input\"
# $files = "server1.security.evtx","server2.security.evtx","server3.security.evtx"

$usernames = "administrator","admin1", "user2"

foreach($logname in (Get-ChildItem -Filter "*.evtx" -Path $folder) ){

foreach($username in $usernames) {

$log = $logname.FullName
$query = @"
<QueryList>
  <Query Id="0" Path="file://$log">
    <Select Path="file://$log">*[ EventData[Data[@Name='TargetUserName'] = '$username']]</Select>
  </Query>
</QueryList>
"@
$filename=$logname.Name
Get-WinEvent   -FilterXml $query | Export-Csv "$outpu$username.ON.$filename.csv"
}
}
