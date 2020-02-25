$Source = "$env:varSource"
$Destination = "$env:varDestination"

Copy-Item -Path $Source -Recurse -Destination $Destination -Force