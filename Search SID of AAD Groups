#----------------------
#If not working, run: 
#   Install-Module -Name AzureAD -AllowClobber
#or
#   Import-Module AzureAD
#----------------------

#Connect to AAD using Connect-AzureAD
IF ($Credentials -isnot [PSCredential]) {
    $Credentials = Get-Credential
}
Connect-AzureAD -Credential $Credentials

#converts the object ID to a SID.
function Convert-ObjectIdToSid
{
    param([String] $ObjectId)

    $d=[UInt32[]]::new(4);[Buffer]::BlockCopy([Guid]::Parse($ObjectId).ToByteArray(),0,$d,0,16);"S-1-12-1-$d".Replace(' ','-')
}


#Prompts for input the name of the AAD group and searches AAD
write-host "Enter the name of the AAD group." -f Yellow
write-host "Search using the first part of the group name, or the entire name: " -f Yellow -NoNewline

#$searchstring = "DGRP"
$searchstring = Read-Host
Get-AzureADGroup -SearchString $searchstring | ForEach {
[pscustomobject] @{Name= $_.DisplayName; Sid=Convert-ObjectIdToSid($_.ObjectId)}
    } | format-table -AutoSize
