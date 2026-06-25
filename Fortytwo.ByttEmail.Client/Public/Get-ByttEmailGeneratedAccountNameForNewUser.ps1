function Get-ByttEmailGeneratedAccountNameForNewUser {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true)]
        [String] $FirstName,

        [Parameter(Mandatory = $true)]
        [String] $LastName,

        [Parameter(Mandatory = $false)]
        [String] $Anchor,

        [Parameter(Mandatory = $true)]
        [String[]] $Groups
    )

    Process {
        if(($Groups | Measure-Object).Count -eq 0) {
            Write-Error -Message "At least one group must be specified in the Groups parameter."
            return
        }

        $Groups | Where-Object {$_ -notmatch "^[a-z0-9A-Z]{8}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{4}-[a-z0-9A-Z]{12}$"} | ForEach-Object {
            throw "Invalid group ObjectId format: $_. Each group must be a valid GUID."
        }

        $ApiEndpoint = "{0}accountnames/generatenewuser" -f $Script:APIRoot
        Write-Debug "Using Bytt.Email to generate account names for new user $FirstName $LastName using endpoint $ApiEndpoint"

        $body = @{
            groupMemberships = ($Groups | Measure-Object).Count -gt 0 ? $Groups : $null
            firstname = $FirstName
            lastname  = $LastName
            anchor = ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Anchor")) ? $Anchor : $null
        }

        try {
            Invoke-RestMethod -Uri $ApiEndpoint -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:EntraIDAccessTokenProfile) -Method Post -Body ($body | ConvertTo-Json -Depth 3) -ContentType "application/json" | Foreach-Object { $_ }
        }
        catch {
            Write-Error -Message "Failed to generate Bytt.Email account names: $_"
        }
    }
}