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

      # [string]$scope = "https://graph.microsoft.com/.default" # Default scope for Microsoft Graph
      [string]$scope = "https://api.partnercenter.microsoft.com/.default"
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

$globalClientId = ""
$globalClientSecret = ""
$globalTenantId = ""
$globalRefreshToken = ""

$accessToken = Get-AccessToken -clientID $globalClientId -clientSecret $globalClientSecret -tenantID $globalTenantId -refreshToken $globalRefreshToken

$uri = "https://api.partnercenter.microsoft.com/v1/customers"

$headers = @{
  Authorization = "Bearer $($accessToken)"
  'Accept'      = 'application/json'
}

Invoke-RestMethod -Uri $uri -Headers $headers

