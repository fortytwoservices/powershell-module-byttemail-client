function Get-ByttEmailAccountNameHistory {
    [CmdletBinding()]

    Param()

    Process {
        $ApiEndpoint = Get-UniverseUrl -Path "changeemail/accountnamehistory"
        Write-Debug "Retrieving ByttEmail account name history from $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-UniverseHeader) -Method Get | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to retrieve ByttEmail account name history: $_"
        }
    }
}