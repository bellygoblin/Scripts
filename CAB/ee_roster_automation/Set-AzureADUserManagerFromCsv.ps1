<#
.SYNOPSIS
Set an Azure AD Supervisor field


.DESCRIPTION
Takes a .csv file of users and their associated manager, and sets their Azure AD Account Supervisor appropriately

.PARAMETER FilePath
Input the path to the .csv file. 
This file should use the following headings format: userprincipalname,manager
The UserPrincipalName and Manager fields should have full user account format: user@domain.com


.EXAMPLE
Set-AzureADUserManagerFromCsv -FilePath C:\scripts\users.csv



.NOTES
You need to run this function as a member of the Global Admins group.

#>

param (
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]
  $FilePath
)

$Users = Import-Csv $FilePath

foreach ($User in $Users) {
  try {
    $AZUser = Get-AzureADUser -ObjectID $User.UserPrincipalName
  }
  
  catch {
    if ($PSItem -like "*Cannot find an object with the identity: '$AZUser'*") {
      Write-Warning "User '$AZUser' does not exist"
    } else {
      Write-Warning "An error occurred: $PSItem"
    }
    continue
  }
  
  Set-AzureADUserManager -ObjectID $User.UserPrincipalName -RefObjectID (Get-AzureADUser -ObjectID $User.Manager).ObjectID

}