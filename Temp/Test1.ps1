$Credential = Get-Credential
$Domain = Read-Host "What domain do you want to connect to?"

Connect-MsolService -Credential $Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg="$Domain" -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$mailboxes = get-mailbox –resultSize unlimited
$rules = $mailboxes | foreach { get-inboxRule –mailbox $_.alias }
$rules | where { ( $_.forwardAsAttachmentTo –ne $NULL  ) –or ( $_.forwardTo –ne $NULL ) –or ( $_.redirectTo –ne $NULL ) } | ft name,identity,ruleidentity