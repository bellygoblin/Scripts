#Get current date
$TimeStamp = Get-Date -UFormat "%m%d%y"

#Define backup destination
$BackupPath = "F:\HyperVBackup\$TimeStamp"

#Get running VMs
$VirtualMachine = Get-VM | Where {$_.State -eq "Running"}

#Export running VMs to backup destination
Export-VM $VirtualMachine -Path $BackupPath