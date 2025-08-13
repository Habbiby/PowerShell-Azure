Connect-AzureAD

$SearchString = "*****"
$DatabricksGroups = Get-AzureADGroup -SearchString $SearchString 
$GroupsToRemove = @(
    ""
    ""
)

#Removing above groups from the searched group list - not required as they're not SCIM provisioned groups.
$Groups = $DatabricksGroups | Where-Object { $_.DisplayName -notin $GroupsToRemove}
#$Groups = Import-Csv "C:\*********\exportGroup.csv"

$Results = ForEach($Group in $Groups){
   Get-AzureADGroupMember -ObjectId $Group.ObjectId -All $true | Select-Object DisplayName, UserPrincipalName,@{n="GroupName";e={$Group.displayName}}
}

$Results | Sort-Object -Descending GroupName 
$Results | Export-Csv "C:\*******\APP-Databricks-Groups.csv" -NoTypeInformation
