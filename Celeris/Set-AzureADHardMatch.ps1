Function Set-AzureADHardMatch {
  param (
      $OnPremUser,
      $CloudUser
  )
  $ADUser = Get-ADUser $OnPremUser
  $AADUser = Get-AzureADUser -ObjectId $CloudUser
  $GUID = [guid]$ADUser.objectGuid
  $ImmutableId = [System.Convert]::ToBase64String($GUID.ToByteArray())
  Set-AzureADUser -ObjectID $AADUser.ObjectID -UserPrincipalName $ADUser.UserPrincipalName -ImmutableId $ImmutableId
}