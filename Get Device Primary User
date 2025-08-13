IF ($Credentials -isnot [PSCredential]) {
    $Credentials = Get-Credential
}
#Connect-AzureAD -Credential $Credentials

$devices = Get-Content -ErrorAction Stop -Path "C:\Temp\LaptopList.txt" | Where { $_ }
Get-AzureADDevice -all 1 | select-object Displayname, ApproximateLastLogonTimeStamp, ObjectId | export-csv "C:\TEMP\AADLaptopList.csv" -NoTypeInformation

#$AADDevices = Get-Content -ErrorAction Stop -Path "C:\Temp\AADLaptopList.csv"
$AADDevices = import-csv "C:\Temp\AADLaptopList.csv"

$DeviceList = ForEach ($device in $devices){
    $AADDevices | where DisplayName -contains $device

}
$CompList = ForEach ($comp in $DeviceList){
        $PrimaryUser = get-azureaddeviceregistereduser -ObjectId $comp.ObjectID | select-object UserPrincipalName
        $PrimaryUser
        IF ($PrimaryUser -eq $null){
            ''
            #@{N="UserPrincipalName";E={"NA"}}
        }
}

$Finallist = $DeviceList + $CompList
$Finallist | ft -AutoSize -Property DisplayName, UserPrincipalName, ObjectID, ApproximateLastLogonTimeStamp

#Table isn't working, have to find a matching value between the two tables or make one
