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
        $Script:APIRoot = "https://{0}/changeemail/" -f $FQDN.TrimEnd('/')
        $Script:EntraIDAccessTokenProfile = $EntraIDAccessTokenProfile

        if($PSCmdlet.ParameterSetName -eq "interactive") {
            $ClientId = "68bf2f1d-b9e1-4477-8b90-81314861f05f"
            $Scope = "https://api.fortytwo.io/.default"
            if($FQDN -like "localhost*" -or $FQDN -eq "localhost") {
                $Scope = "https://dev-api.byfortytwo.com/.default"
                $ClientId = "b24eb00a-7f91-489b-b321-3b018da0e8a8"
            }

            Add-EntraIDInteractiveUserAccessTokenProfile -ClientId $ClientId -Scope $Scope -Name $EntraIDAccessTokenProfile
        }
        Get-EntraIDAccessToken -Profile $EntraIDAccessTokenProfile | Out-Null
    }
}
