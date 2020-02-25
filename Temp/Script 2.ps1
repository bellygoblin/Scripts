#Get current date
$TimeStamp = Get-Date -UFormat "%m%d%y"

#Define backup destination
$varBackupPath = "$varBackupPath\" . $TimeStamp

#Export specific VM to backup destination
Export-VM -VM ($varVirtualMachine) -Path $varBackupPath