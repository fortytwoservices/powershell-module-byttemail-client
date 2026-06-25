function Get-ByttEmailAccountNameHistory {
    [CmdletBinding()]

    Param()

    Process {
        $ApiEndpoint = "{0}accountnamehistory" -f $Script:APIRoot
        Write-Debug "Retrieving ByttEmail account name history from $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Get | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to retrieve ByttEmail history: $_"
        }
    }
}