function Get-AccessToken {
  param (
      [Parameter(Mandatory=$true)]
      [string]$clientID,

      [Parameter(Mandatory=$true)]
      [string]$clientSecret,

      [Parameter(Mandatory=$true)]
      [string]$tenantID, # Your tenantID

      [Parameter(Mandatory=$true)]
      [string]$refreshToken, # Your refreshToken

      [string]$scope = "https://graph.microsoft.com/.default" # Default scope for Microsoft Graph
  )

  # Token endpoint
  $tokenUrl = "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token"

  # Prepare the request body
  $body = @{
      client_id     = $clientID
      scope         = $scope
      client_secret = $clientSecret
      grant_type    = "refresh_token"
      refresh_token = $refreshToken
  }

  # Request the token
  $response = Invoke-RestMethod -Method Post -Uri $tokenUrl -ContentType "application/x-www-form-urlencoded" -Body $body

  # Return the access token
  return $response.access_token
}

$accessToken = Get-AccessToken -clientID "a4bfd954-b3dd-48b3-87ab-1b36bc295b55" -clientSecret "QYr8Q~nveN_pVtfHLUM~0kkIsWC1V_o3mlNeGdai" -tenantID "3569e393-775f-4a5b-b5e4-5699cbc55b95" -refreshToken "0.ATYAk-NpNV93W0q15FaZy8VblVTZv6Tds7NIh6sbNrwpW1U2AOM.AgABAAEAAAAmoFfGtYxvRrNriQdPKIZ-AgDs_wUA9P-nU_b2DEiJr_ydmpSxLhjd-YW1t_5sdb1CG-r14mHIFHcjLrsoin3Sh0utnRKdha7x29WPEjbNnKrxEgATKf4ykso89rXjJg4zE4qKOptbCVHfOiteiXHKybqGI1pCHzLPfJCI9QW-2rRkdiIbMr5tMZLtWSgt5GdJoS6OXBy7FysJybNOgJ8KSFwb3uGweTkir36754ZyJvFN4f61n6EH1tize4f9-Fb4OCwQruJ0grDHDghsHVnEsI8W46iN_te9m3l4cD0EJKV_8DuBjSM8u2cmjdeVKZRx-5P8FM4ROVceZEuvZx1yDlhPPCcBucYHkvPnphtyDLBSZ2SrpcNpCyVkd_OM6T4Woq11hmhX5dSaU7bFskBcCPWgVaVuOMydmlFz7BPKXpVzofAB57ze-HcWJxcnUdnAXgd9JQliSPFSvoxs9dHKNbh6pA16wrms06LXYLjMEmChOt08_YWMMNcQt0ay2Kv6cd86mHSWf5dibrKeB5SrQNtSGnUNsUUtdpwSD4G6ypM8c2JK-B4cRpcli8J2-CoubOrBek1dYgIsn0aXvVil-oIp5rSaG9cfn-qNWgrMW1CiK4OHXIoFL7wIcSdDM5JC5RdyVcMwuYI3gC_BoQ3PpANxAU5N3OmnDcbrMwxjDKV_BhpFI8lv2vtHPfFQ1OW0utFqTpV8TzX9sbzy98FmT6jB2FdBkXwcsjVEKWJhOjGuZE9nc6V4dWnwPnveUuyfWqerqe7a2I748mxVOEhq8ZmPjYAt1P2AytcLhyYK49fQAl5imPtwmACT_eGzMnDIq_2v1JVuHNiq1Kx2BumqMbqHE85HA6nPXAjN"

$uri = "https://api.partnercenter.microsoft.com/v1/customers"
$headers = @{
  Authorization = "Bearer $($accessToken)"
  'Accept'      = 'application/json'
}

$Customers = Invoke-RestMethod -Uri $uri -Headers $headers

foreach ($Customer in $Customers.items) {
  $CustomerTenantId = $Customer.id

  if ($CustomerTenantId == "0054bdf2-4279-4340-a6d9-98c9316759b2") {
    connect-partnercenter -accesstoken $accesstoken 
    get-partnercustomersubscribedsku -customerID $CustomerTenantId
  }
}