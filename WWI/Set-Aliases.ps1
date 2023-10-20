$NewDomain = "cbww.com"

$Users=Get-Mailbox
$Users | Foreach-Object{ 
$user=$_
$UserName =($user.PrimarySmtpAddress -split "@")[0]
$Emailaddress=$UserName+"@"+$NewDomain
$user | Set-Mailbox -EmailAddresses @{add=$Emailaddress} 
}

$Groups=Get-DistributionGroup
$Groups | Foreach-Object{ 
$group=$_
$groupname =($group.PrimarySmtpAddress -split "@")[0]
$Emailaddress=$groupname+"@"+$NewDomain
$group | Set-DistributionGroup -EmailAddresses @{add=$Emailaddress} 
} 