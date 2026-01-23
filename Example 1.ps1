Import-Module EntraIDAccessToken
Import-Module ./Fortytwo.ByttEmail.Client -Force -Verbose

# Connect-ByttEmail
Connect-ByttEmail -EntraIDAccessTokenProfile Bytt.Email.Interactive -FQDN "localhost:7154"

Get-ByttEmailHistory -Verbose -Debug

New-ByttEmailHistory -Email "marius@gammel.no"  -LastSeen (Get-Date).AddDays(-10) -ObjectId (New-Guid).ToString()


Get-ByttEmailHistory 

Get-ByttEmailGeneratedAddressForExistingUser -ObjectId ce3d945f-fc56-4b19-9891-665ca05a998d | ConvertTo-Json -Depth 10

Get-ByttEmailGeneratedAddressForNewUser -FirstName "Marius" -LastName "Solbakken Mellum" -Anchor "4233" -Groups "23e5eefb-ef8e-443b-8d3a-95d40ffa807e" | ConvertTo-Json -Depth 10