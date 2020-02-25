$Date = Get-Date -UFormat "%y%m%d"
$Limit = (Get-Date).AddDays(-2)
$LocalPath = "C:\Hyper-V\Exports"

Invoke-Command -ComputerName 2019-7050-B -ScriptBlock {$Date = Get-Date -UFormat "%y%m%d" ; get-vm | export-vm -Path c:\hyper-v\exports\$Date}

Copy-Item -Path "\\2019-7050-b\c$\hyper-v\exports\$Date" -Destination C:\Hyper-V\Exports\$Date -Recurse

Invoke-Command -ComputerName 2019-7050-B -ScriptBlock {Remove-Item -Path c:\hyper-v\exports\* -Force -Recurse}
 
Get-ChildItem -Path $LocalPath -Recurse -Force | Where-Object {$PSItem.PSIsContainer -and $PSItem.CreationTime -lt $Limit} | Remove-Item -Force