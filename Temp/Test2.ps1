Function Get-ForwardingRules {
    $mailboxes = get-mailbox –resultSize unlimited
    $rules = $mailboxes | foreach { get-inboxRule –mailbox $_.alias }
    $rules | where { ( $_.forwardAsAttachmentTo –ne $NULL  ) –or ( $_.forwardTo –ne $NULL ) –or ( $_.redirectTo –ne $NULL ) } | ft name,identity,ruleidentity
}


$Tenants = Get-MsolPartnerContract -All; $Tenants | foreach {$Domains = $_.TenantId; Get-MsolDomain -TenantId $Domains | fl @{Label="TenantId";Expression={$Domains}},name}
a23ceffd-e47d-4a47-9b1c-535148e6cf0b

$domain = Read-Host "What domain do you want to connect to?"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg=$domain -Credential $cred -Authentication Basic -AllowRedirection