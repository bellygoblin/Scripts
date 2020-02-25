<#
This will be versioning, changes, and description


#>

Import-Module ActiveDirectory

## This is used to convert Active Directory Collections to an array so that it can be manipulated
Function Convert-ToArray {
  Begin {
    $Output = @(); 
  }
  
  Process {
    $Output += $_; 
  }
  
  End {
    Return ,$output; 
  }
}

## Block to handle the X amount of days since last logon
[int]$DaysBack = $env:varDaysBack
$CurrentDate = Get-Date
$DaysBackDate = $CurrentDate.AddDays($DaysBack * -1)

## Accounts and properties will be put into records and added to a hashtable
$Table = @()

$Record = @{
     "Last Logon" = ""
     "Account" = ""
     "Creation Date" = ""
     "UPN" = ""
     "Password Changed" = ""
     "OU Location" = ""
     "Group Membership" = ""
}

## Put filter and searchbase criteria into variables for easier modifcation
$Filter = {Name -notlike "*mailbox*" -and Name -notlike "IUSR*" -and Name -notlike "IWAM*" -and Name -notlike "AAD*" -and Name -notlike "*SQL*" -and Name -notlike "QBData*"}
$SearchBase = Get-ADDomain | Select-Object -ExpandProperty DistinguishedName
$EnabledUsers = Get-ADUser -Filter $Filter -SearchBase $SearchBase -Properties * | Where-Object {$PSItem.DistinguishedName -notlike "*OU=Celeris Networks*" -and $PSItem.Enabled -eq $True}

## Simple ForEach and If statements to go through all Active Directory users, only keeping the ones matching the last logon criteria, and modifying OU and Groups to become strings for output
ForEach ($EnabledUser in $EnabledUsers) {
    If ($EnabledUser.LastLogonDate -lt $DaysBackDate) {
        
        ## Section to take the collection of AD Group Memberships, convert to an array, and modify so that only the group name is returned
        $ADGroupsFull = $EnabledUser.MemberOf | Convert-ToArray
        $ADGroups = ForEach ($G in $ADGroupsFull) {
            $G = $G.Split(",")[0]
            $G.SubString($G.IndexOf("=")+1)
                    }
        ## $ofs is a special variable that contains the string to be used as the Output Field Separator. Putting an array variable in double quotes converts it to a string
        $ofs = ", "
        $ADGroups = "$ADGroups"

        ## Section to take the collection of Distinguished Name of an account, convert it to an array, and modify so that only the OU the user is in is returned
        $OUNameFull = $EnabledUser.DistinguishedName | Convert-ToArray
        $OUName = ForEach ($OU in $OUNameFull) {
            $OU = $OU.Split(",")[1]
            $OU.SubString($OU.IndexOf("=")+1)
                    }
        
        ## Add user properties to the Record
        $Record."Last Logon" = $EnabledUser.LastLogonDate
        $Record."Account" = $EnabledUser.Name
        $Record."Creation Date" = $EnabledUser.whenCreated
        $Record."UPN" = $EnabledUser.UserPrincipalName
        $Record."Password Changed" = $EnabledUser.PasswordLastSet
        $Record."OU Location" = $OUName
        $Record."Group Membership" = $ADGroups
        
        ## Create a new object using the previously created Record and add it to the Table
        $ObjRecord = New-Object PSObject -Property $Record
        $Table += $ObjRecord
    }
}

## Export the table to a .csv file
$OutTable = $Table.GetEnumerator( ) | Sort-Object -Property "Account" | Select-Object -Property "Account", "Last Logon", "Creation Date", "UPN", "Password Changed", "OU Location", "Group Membership" | Export-Csv -Path C:\scripts\InactiveUsers.csv