# Get list of customers
$uri = "https://api.partnercenter.microsoft.com/v1/customers"
$headers = @{
    Authorization = "Bearer $($AccessToken)"
    'Accept'      = 'application/json'
}

$Customers = Invoke-RestMethod -Uri $uri -Headers $headers

# Loop through each customer and run the existing script
foreach ($Customer in $Customers.value) {
    $CustomerTenantId = $Customer.id

    # Consent to required applications
    $uri = "https://api.partnercenter.microsoft.com/v1/customers/$CustomerTenantId/applicationconsents"
    $body = @{
        applicationGrants = @(
            @{
                enterpriseApplicationId = "00000003-0000-0000-c000-000000000000"
                scope                   = "Directory.Read.All,Directory.AccessAsUser.All"
            },
            @{
                enterpriseApplicationId = "00000002-0000-0ff1-ce00-000000000000"
                scope                   = "Exchange.Manage"
            }
        )
        applicationId   = $AppId
        displayName     = $AppDisplayName
    } | ConvertTo-Json

  Invoke-RestMethod -Uri $uri -Headers $headers -Method POST -Body $body -ContentType 'application/json'

  }					