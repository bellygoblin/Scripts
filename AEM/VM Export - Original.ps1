#Get current date
$TimeStamp = Get-Date -UFormat "%y%m%d"

#Define backup destination
$varBackupPath = "$env:varBackupPath\$TimeStamp"

#Define virtual machines to export
$varVM1 = "$env:varVM1"
$varVM2 = "$env:varVM2"
$varVM3 = "$env:varVM3"
$varVM4 = "$env:varVM4"
$varVM5 = "$env:varVM5"

#Put virtual machines into an array
$VMs = $varVM1, $varVM2, $varVM3, $varVM4, $varVM5

#Remove null value items from the $VMs array
#Export specific VM to backup destination
foreach ($VM in ($VMs | ? {$_})) {
    Export-VM -Name $VM -Path $varBackupPath
}