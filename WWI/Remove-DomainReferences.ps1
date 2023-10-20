$InitialDomain = Get-AzureADDomain | Where-Object {$PSItem.IsInitial -eq $True}

$Users=Get-Mailbox
$AZUsers = Get-AzureADUser -all $true | Where-Object {$PSItem.UserType -eq "Member"}
$Groups=Get-DistributionGroup
$O365Groups = Get-UnifiedGroup
$RuinUsers = get-msoluser -domainname cbww.com

$Users | Foreach-Object{ 
$user=$_
$UserName =($user.PrimarySmtpAddress -split "@")[0]
$SMTP ="SMTP:"+ $UserName +"@"+($InitialDomain.Name)
$Emailaddress=$UserName+"@"+($InitialDomain.Name)
$user | Set-Mailbox -EmailAddresses $SMTP -WindowsEmailAddress $Emailaddress -MicrosoftOnlineServicesID $Emailaddress
}

$AZUsers | ForEach-Object {
$AZUser = $_
$AZUsername = ($AZUser.UserPrincipalName -split "@")[0]
$AZUPN = $AZUsername+"@"+($InitialDomain.Name)
$AZUser | Set-AzureADUser  -UserPrincipalName $AZUPN
}

$Groups | Foreach-Object{ 
$group=$_
$groupname =($group.PrimarySmtpAddress -split "@")[0]
$SMTP ="SMTP:"+$groupname+"@"+($InitialDomain.Name) 
$Emailaddress=$groupname+"@"+($InitialDomain.Name)
$group |Set-DistributionGroup -EmailAddresses $SMTP -WindowsEmailAddress $Emailaddress
} 

$O365Groups | Foreach-Object{ 
$O365group=$_
$O365groupname =($O365group.PrimarySmtpAddress -split "@")[0]
$O365Emailaddress=$O365groupname+"@"+($InitialDomain.Name)
$O365group | Set-UnifiedGroup -PrimarySMTPAddress $O365Emailaddress
$O365group | Set-UnifiedGroup -EmailAddresses $O365Emailaddress
}

foreach ($ruin in $RuinUsers) {
    set-mailbox ($ruin.userprincipalname) -EmailAddresses ($ruin.userprincipalname)
}