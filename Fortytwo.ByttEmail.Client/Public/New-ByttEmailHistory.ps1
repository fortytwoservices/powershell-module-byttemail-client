function New-ByttEmailHistory {
    [CmdletBinding(SupportsShouldProcess = $true)]

    Param(
        [Parameter(Mandatory = $true)]
        [String] $Email,

        [Parameter(Mandatory = $false)]
        [String] $Anchor,

        [Parameter(Mandatory = $false)]
        [ValidatePattern("^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$")]
        [String] $ObjectId,

        [Parameter(Mandatory = $false)]
        [DateTime] $LastSeen = (Get-Date)
    )

    Process {
        $ApiEndpoint = "{0}history" -f $Script:APIRoot
        Write-Debug "Sending post request to $ApiEndpoint"

        $body = @{
            email    = $Email
            lastseen = $LastSeen.ToString("yyyy-MM-ddTHH:mm:ssZ")
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Anchor")) {
            $body["anchor"] = $Anchor
        }

        if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("ObjectId")) {
            $body["objectid"] = $ObjectId
        }

        try {
            if ( $PSCmdlet.ShouldProcess("ByttEmail history for $($Email)", "Create")) {
                Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Post -Body ($body | ConvertTo-Json -Depth 3) -ContentType "application/json" | Foreach-Object { $_ }
            }
        }
        catch {
            Write-Error -Message "Failed to create ByttEmail history: $_"
        }
    }
}