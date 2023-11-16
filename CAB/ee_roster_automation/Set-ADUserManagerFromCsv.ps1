<#
.SYNOPSIS
Set an Active Directory Manager field


.DESCRIPTION
Takes a .csv file of users and their associated manager, and sets their Active Directory Account Manager appropriately

.PARAMETER FilePath
Input the path to the .csv file. 
This file should use the following headings format: userprincipalname,manager
The UserPrincipalName and Manager fields should have full user account format: user@domain.com


.EXAMPLE
Set-ADUserManagerFromCsv -FilePath C:\scripts\users.csv



.NOTES
You need to run this function as a member of the Domain Admins group, or have equivilent permissions to modify User Accounts in Active Directory

#>

param (
  [Parameter(Mandatory=$true)]
  [ValidateNotNullOrEmpty()]
  [string]
  $FilePath
)

$Users = Import-Csv $FilePath

foreach ($User in $Users) {
  $PrimaryUPN = $user.UserPrincipalName
  $ManagerUPN = $user.Manager
  $ADUserAlias,$ADDomain = $PrimaryUPN -split "@"
  $Manager,$ManagerDomain = $ManagerUPN -split "@"
  try {
    $ADUser = Get-ADuser -Identity $ADUserAlias

  }
  
  catch {
    if ($PSItem -like "*Cannot find an object with the identity: '$ADUser'*") {
      Write-Warning "User '$ADUser' does not exist"
    } else {
      Write-Warning "An error occurred: $PSItem"
    }
    continue
  }

  Set-ADUser -Identity $ADUser -Manager $Manager

}