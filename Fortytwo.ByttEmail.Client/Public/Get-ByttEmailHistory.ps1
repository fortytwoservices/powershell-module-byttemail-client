function Get-ByttEmailHistory {
    [CmdletBinding()]

    Param()

    Process {
        $ApiEndpoint = "{0}history" -f $Script:APIRoot
        Write-Debug "Retrieving ByttEmail history from $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Get | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to retrieve ByttEmail history: $_"
        }
    }
}