#$SID = Get-Content -ErrorAction Stop -Path "C:\Temp\SIDList.txt" | Where { $_ }
$SID = "", ""


IF ($Credentials -isnot [PSCredential]) {
    $Credentials = Get-Credential
}
Connect-AzureAD -Credential $credentials

$Results = ForEach($ID in $SID){

    $Text = $ID.Replace('S-1-12-1-', '')
    $Array = [UInt32[]]$Text.Split('-')

    $Bytes = New-Object 'Byte[]' 16
    [Buffer]::BlockCopy($Array, 0, $bytes, 0, 16)
    [Guid]$GUID = $Bytes

    Get-AzureADObjectByObjectId -ObjectIds $GUID | Select-Object DisplayName, @{Name="SID";Expression={$ID}}, ObjectId, Description
}


Write-Output $Results | Format-table -AutoSize
