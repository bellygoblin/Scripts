# Set Local Admin Account
$AdminPassword = $ENV:AdminPassword
New-LocalUser -Name admin -Password $AdminPassword -PasswordNeverExpires -AccountNeverExpires
Add-LocalGroupMember -Group Administrators -Member Admin

# Netextender Profile Setup
