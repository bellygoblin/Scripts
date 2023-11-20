function Get-AccessToken {
  param (
      [Parameter(Mandatory=$true)]
      [string]$clientID,

      [Parameter(Mandatory=$true)]
      [string]$clientSecret,

      [Parameter(Mandatory=$true)]
      [string]$tenantID = "common", # Your tenantID

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

$accessToken = Get-AccessToken -clientID "" -clientSecret "" -tenantID "" -refreshToken ""

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