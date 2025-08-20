#$SID = Get-Content -ErrorAction Stop -Path "C:\Temp\ObjIDList.txt" | Where { $_ }
$objectID ="", ""

IF ($Credentials -isnot [PSCredential]) {
    $Credentials = Get-Credential
}
Connect-AzureAD -Credential $Credentials

$Results = ForEach($ID in $ObjectID){
    
    $bytes = [Guid]::Parse($ID).ToByteArray()
    $array = New-Object 'UInt32[]' 4

    [Buffer]::BlockCopy($bytes, 0, $array, 0, 16)
    $sid = "S-1-12-1-$array".Replace(' ', '-')


    Get-AzureADObjectByObjectId -ObjectIds $ID | Select-Object ObjectId, DisplayName,@{Name="SID";Expression={$SID}}, Description
}


Write-Output $Results | Format-table -AutoSize
