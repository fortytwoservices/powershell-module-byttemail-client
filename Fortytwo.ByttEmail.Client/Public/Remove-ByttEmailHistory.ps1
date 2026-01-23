function Remove-ByttEmailHistory {
    [CmdletBinding(SupportsShouldProcess = $true)]

    Param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = "id")]
        [ValidatePattern("^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$")]
        [String] $Id
    )

    Process {
        $ApiEndpoint = "{0}history/{1}" -f $Script:APIRoot, $Id
        Write-Debug "Sending delete request to $ApiEndpoint"

        try {
            if ($PSCmdlet.ShouldProcess("ByttEmail history with ID $($Id)", "Delete")) {   
                Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Delete | Out-Null
            }
        }
        catch {
            Write-Error -Message "Failed to delete ByttEmail history with ID $($Id): $_"
        }
    }
}