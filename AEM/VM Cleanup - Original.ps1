#Specify location for cleanup
$BackupPath = "$env:varBackupPath"

#Get current date and date 30 days ago
$CurrentDate = Get-Date
$DaysBack = "$env:varDaysBack"

#Define 30 days ago date
$DateToDelete = $CurrentDate.AddDays($DaysBack)

#Remove items in specified path older than 30 days
Get-ChildItem $BackupPath -Recurse | Where-Object { $_.LastWriteTime -lt $DateToDelete } | Remove-Item