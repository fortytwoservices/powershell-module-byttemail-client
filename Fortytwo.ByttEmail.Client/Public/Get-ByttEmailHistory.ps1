function Get-ByttEmailHistory {
    [CmdletBinding()]

    Param()

    Process {
        $ApiEndpoint = Get-UniverseUrl -Path "changeemail/history"
        Write-Debug "Retrieving ByttEmail history from $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-UniverseHeader) -Method Get | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to retrieve ByttEmail history: $_"
        }
    }
}