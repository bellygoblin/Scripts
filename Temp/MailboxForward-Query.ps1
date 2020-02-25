#Import the right module to talk with AAD
import-module MSOnline

#Let's get us an admin cred!
$userCredential = Get-Credential

#This connects to Azure Active Directory
Connect-MsolService -Credential $userCredential

$Domains = Get-MsolPartnerContract -All | Select -ExpandProperty DefaultDomainName

ForEach ($Domain in $Domains) {

    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg="$Domain" -Credential $userCredential -Authentication Basic -AllowRedirection
    Import-PSSession $Session
    
    $Mailboxes = Get-Mailbox –ResultSize Unlimited
    $Rules = $Mailboxes | ForEach { Get-InboxRule –Mailbox $_.alias }
    $Rules | Where { ( $_.forwardAsAttachmentTo –ne $NULL  ) –or ( $_.forwardTo –ne $NULL ) –or ( $_.redirectTo –ne $NULL ) } | ft name,identity,ruleidentity | Export-Csv -Append MailboxForwardingRules.csv

    Remove-PSSession $Session
}





