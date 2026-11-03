function Get-ByttEmailGeneratedAccountNameForIdentity {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidatePattern("^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$")]
        [String] $Id
    )

    Process {
        $ApiEndpoint = Get-UniverseUrl -Path "changeemail/accountnames/generate/$Id"
        Write-Debug "Using Bytt.Email to generate account names for identity $Id using endpoint $ApiEndpoint"

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-UniverseHeader)
        }
        catch {
            Write-Error -Message "Failed to generate Bytt.Email account names: $_"
        }
    }
}