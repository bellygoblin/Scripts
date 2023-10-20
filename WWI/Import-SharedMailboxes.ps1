# Import CSV file
$Datas = Import-Csv "~\Scripts\WWI\Mailboxes.csv"

# Get all recipients
$Recipients = Get-Recipient -ResultSize Unlimited | Select-Object Name

foreach ($Data in $Datas) {

    # Check if shared mailbox does not exist
    If (($Recipients | Where { $_.Name -eq $Data.Name }) -eq $Null) {

        # Create shared mailbox
        New-Mailbox -Name $Data.Name -DisplayName $Data.DisplayName -Shared
        Write-Host -f Green "Shared mailbox '$($Data.Name)' created successfully."
    }
    Else {
        Write-host -f Green "Shared Mailbox '$($Data.Name)' already exists."
    }
}