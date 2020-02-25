#Get current date
$TimeStamp = Get-Date -UFormat "%y%m%d"

#Define backup destination
$BackupPath = "$env:varBackupPath\$TimeStamp"

#Create array of VMs to export
$VMs = $env:varVM1, $env:varVM2, $env:varVM3, $env:varVM4, $env:varVM5

#Remove null value items from the $VMs array
#Export specific VM to backup destination
foreach ($VM in ($VMs | ? {$_})) {
    Export-VM -Name $VM -Path $BackupPath
}