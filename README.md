# Documentation for module Fortytwo.ByttEmail.Client

## Install and connect

```PowerShell
Install-Module Fortytwo.ByttEmail.Client -Scope CurrentUser
Connect-ByttEmail
```

## Work with history

```PowerShell
Get-ByttEmailHistory | Format-Table

New-ByttEmailHistory -Email "marius@gammel.no"  -LastSeen (Get-Date).AddDays(-10)

Get-ByttEmailHistory | Where-Object Email -like "*@gammel.no" | Remove-ByttEmailHistory
```

## Generate email for new user

```PowerShell
Get-ByttEmailGeneratedAddressForNewUser -FirstName "Marius" -LastName "Solbakken Mellum" -Anchor "4233" -Groups "23e5eefb-ef8e-443b-8d3a-95d40ffa807e" | ConvertTo-Json -Depth 10
```

## Generate email for existing user 

Most useful for testing new patterns

```PowerShell
Get-ByttEmailGeneratedAddressForExistingUser -ObjectId "ce3d945f-fc56-4b19-9891-665ca05a998d" | ConvertTo-Json -Depth 10

Get-ByttEmailGeneratedAddressForExistingUser -ObjectId "ce3d945f-fc56-4b19-9891-665ca05a998d" -Groups "23e5eefb-ef8e-443b-8d3a-95d40ffa807e" | ConvertTo-Json -Depth 10
```

