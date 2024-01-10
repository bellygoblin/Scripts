function Write-DRMMDiag ($Messages) {
  write-host  '<-Start Diagnostic->'
  foreach ($Message in $Messages) { $Message }
  write-host '<-End Diagnostic->'
} 
function Write-DRMMAlert ($Message) {
  write-host '<-Start Result->'
  write-host $message
  write-host '<-End Result->'
}

Import-Module ActiveDirectory

$ADUser = Get-ADUser $env:useraccount -Properties *

if (!$aduser.enabled) {
  write-DRMMAlert="Account Locked"
  Write-DRMMDiag ($ADUser)
} else {
  write-DRMMAlert="Healthy"
}