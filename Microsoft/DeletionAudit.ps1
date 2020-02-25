<#
.SYNOPSIS
  This script will eport the properties of an Active Directory account to a .csv file 
  required by Celeris Networks for Account Control Process.
.DESCRIPTION
  The Active Directory properties will be put into a Hash Table. One property (AD Group Membership)
  has to be converted from an object > array > string in order to export correctly.
.INPUTS
  Active Directory Account Name
.OUTPUTS
  Outputs a .csv file to the following location: C:\Scripts\UserAudit.csv
.NOTES
  Version:        1.0
  Author:         Brian Mitchell
  Creation Date:  12/11/19
  Purpose:        To record User Account properties prior to deletion
  Change:         Initial script development
#>



#---------------------------------------------------------[Initialisations]--------------------------------------------------------

Import-Module ActiveDirectory



#----------------------------------------------------------[Declarations]----------------------------------------------------------

$FolderPath = "C:\Scripts"
$User = $env:User
$Table = @()
$Record = @{
     "Last Logon" = ""
     "Account" = ""
     "Creation Date" = ""
     "UPN" = ""
     "Password Changed" = ""
     "OU Location" = ""
     "Group Membership" = ""
     "Last Modified" = ""
     "Home Directory" = ""
     "Enabled" = ""
}



#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function Convert-ToArray {
  Begin {
    $Output = @(); 
  }
  
  Process {
    $Output += $_; 
  }
  
  End {
    Return ,$Output; 
  }
}



#-----------------------------------------------------------[Execution]------------------------------------------------------------

If (! (Test-Path $FolderPath)) {
    New-Item -ItemType Directory -Force -Path $FolderPath
}

$UserProp = Get-ADUser -Identity $User -Properties *

$ADGroupsFull = $UserProp.MemberOf | Convert-ToArray
$ADGroups = ForEach ($G in $ADGroupsFull) {
    $G = $G.Split(",")[0]
    $G.SubString($G.IndexOf("=")+1)
        }

$ofs = ", "
$ADGroups = "$ADGroups"

$Record."Account" = $UserProp.DisplayName
$Record."UPN" = $UserProp.UserPrincipalName
$Record."Last Logon" = $UserProp.LastLogonDate
$Record."OU Location" = $UserProp.DistinguishedName
$Record."Creation Date" = $UserProp.Created
$Record."Last Modified" = $UserProp.Modified
$Record."Home Directory" = $UserProp.HomeDirectory
$Record."Enabled" = $UserProp.Enabled
$Record."Password Changed" = $UserProp.PasswordLastSet
$Record."Group Membership" = $ADGroups

$ObjRecord = New-Object PSObject -Property $Record
$Table += $ObjRecord

$OutTable = $Table.GetEnumerator( ) | Sort-Object -Property "Account" | Select-Object -Property "Account", "UPN", "Enabled", "Creation Date", "Last Logon", "Last Modified", "Password Changed", "Home Directory", "OU Location", "Group Membership" | Export-Csv -Path $FolderPath\UserAudit.csv -NoTypeInformation