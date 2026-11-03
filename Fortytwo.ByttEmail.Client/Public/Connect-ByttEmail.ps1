<#
.SYNOPSIS
Connects to the Inbound Provisioning API using the specified credentials. The credentials are stored in the script scope and used for all subsequent calls to the API.

.EXAMPLE
$Credential = Get-Credential
Connect-ByttEmail

#>
function Connect-ByttEmail {
    [CmdletBinding(DefaultParameterSetName = "interactive")]

    Param
    (
        [Parameter(Mandatory = $false)]
        [ValidateScript( { $_ -match '^[a-zA-Z0-9.-]+(:[0-9]+)?$' } )]
        [String] $FQDN = "api.fortytwo.io",

        [Parameter(Mandatory = $false, ParameterSetName = "accesstokenprofile")]
        [String] $EntraIDAccessTokenProfile = "Bytt.Email.Interactive"
    )
    
    Process {
        Write-Warning "The Connect-ByttEmail cmdlet is deprecated, please use Connect-Universe instead"
        
        if($PSCmdlet.ParameterSetName -eq "interactive") {
            Connect-Universe -FQDN $FQDN -Environment ($FQDN -eq "api.fortytwo.io" ? "Production": "Development")
        } else {
            Connect-Universe -AccessTokenProfile $EntraIDAccessTokenProfile -FQDN $FQDN -Environment ($FQDN -eq "api.fortytwo.io" ? "Production": "Development")
        }        
    }
}
