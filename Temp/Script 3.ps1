#Specify location for cleanup
$varBackupPath = "$env:varBackupPath"

#Get current date and date 30 days ago
$CurrentDate = Get-Date
$varDaysBack = "$env:varDaysBack"

#Define 30 days ago date
$DateToDelete = $CurrentDate.AddDays($varDaysBack)

#Remove items in specified path older than 30 days
Get-ChildItem $varBackupPath -Recurse | Where-Object { $_.LastWriteTime -lt $DateToDelete } | Remove-Item -WhatIf