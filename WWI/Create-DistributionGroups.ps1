$groups = import-csv [path to csv]

foreach ($group in $groups) {
    New-DistributionGroup -Name $group.Name -DisplayName $group.DisplayName -PrimarySmtpAddress $group.PrimarySMTPAddress -Members ($group.Members -split ",") -RequireSenderAuthenticationEnabled $false -type Distribution
}