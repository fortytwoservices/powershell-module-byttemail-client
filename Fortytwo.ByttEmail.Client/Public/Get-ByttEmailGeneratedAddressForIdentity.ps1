function Get-ByttEmailGeneratedAddressForIdentity {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern("^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$")]
        [String] $Id
    )

    Process {
        $ApiEndpoint = "{0}emailaddresses/generate/$Id" -f $Script:APIRoot
        Write-Debug "Using Bytt.Email to generate email addresses for identity $Id using endpoint $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile)
        }
        catch {
            Write-Error -Message "Failed to generate Bytt.Email addresses: $_"
        }
    }
}