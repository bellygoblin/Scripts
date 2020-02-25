#Get current date and date 30 days ago
$CurrentDate = Get-Date

#Define 30 days ago date
$DateToDelete = $CurrentDate.AddDays($env:varDaysBack)

#Remove items in specified path older than 30 days
Get-ChildItem $env:varBackupPath -Recurse | Where-Object { $_.LastWriteTime -lt $DateToDelete } | Remove-Item