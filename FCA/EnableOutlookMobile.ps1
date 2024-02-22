$User = Read-Host -Prompt 'Input the email you wish to disable mobile access for'

Set-CASMailbox "$User" -EwsAllowList @{Add="Outlook-iOS/*","Outlook-Android/*"}
Set-CASMailbox "$User" -OutlookMobileEnabled $true

Write-Output "Mobile email access for $User has been enabled.`n"