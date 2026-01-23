function Get-ByttEmailGeneratedAddressForExistingUser {
    [CmdletBinding(DefaultParameterSetName = "objectid")]

    Param(
        [Parameter(Mandatory = $true, ParameterSetName = "objectid")]
        [ValidatePattern("^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$")]
        [String] $ObjectId,

        [Parameter(Mandatory = $true, ParameterSetName = "userprincipalname")]
        [ValidateScript( { $_ -match '^[^@\s]+@[^@\s]+\.[^@\s]+$' } )]
        [String] $UserPrincipalName,

        [Parameter(Mandatory = $false)]
        [String[]] $Groups
    )

    Process {
        $ApiEndpoint = "{0}emailaddresses/generate" -f $Script:APIRoot
        Write-Debug "Using Bytt.Email to generate email addresses for $($ObjectId ?? $UserPrincipalName) using endpoint $ApiEndpoint"

        $body = @{
            groupMemberships = ($Groups | Measure-Object).Count -gt 0 ? $Groups : $null
        }

        if( $PSCmdlet.ParameterSetName -eq "objectid" ) {
            $body["objectId"] = $ObjectId
        }
        else {
            $body["userPrincipalName"] = $UserPrincipalName
        }

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Post -Body ($body | ConvertTo-Json -Depth 3) -ContentType "application/json" | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to generate Bytt.Email addresses: $_"
        }
    }
}