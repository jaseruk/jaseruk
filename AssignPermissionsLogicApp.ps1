Connect-AzureAD
$graph = Get-AzureADServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"

$PermissionDirReadAll = $graph.AppRoles | where Value -Like "Directory.Read.All" | Select-Object -First 1
$PermissionPolicyReadAll = $graph.AppRoles | where Value -Like "Policy.Read.All" | Select-Object -First 1
$PermissionPolicyRWCA = $graph.AppRoles | where Value -Like "Policy.ReadWrite.ConditionalAccess" | Select-Object -First 1
$PermissionPolicyAppReadAll = $graph.AppRoles | where Value -Like "Application.Read.All" | Select-Object -First 1


$msi = Get-AzureADServicePrincipal -ObjectId 92856a23-7172-48da-9f72-48fc5d7ee7af

New-AzureADServiceAppRoleAssignment -Id $PermissionDirReadAll.Id -ObjectId $msi.ObjectId -PrincipalId $msi.ObjectId -ResourceId $graph.ObjectId
New-AzureADServiceAppRoleAssignment -Id $PermissionPolicyReadAll.Id -ObjectId $msi.ObjectId -PrincipalId $msi.ObjectId -ResourceId $graph.ObjectId
New-AzureADServiceAppRoleAssignment -Id $PermissionPolicyRWCA.Id -ObjectId $msi.ObjectId -PrincipalId $msi.ObjectId -ResourceId $graph.ObjectId
New-AzureADServiceAppRoleAssignment -Id $PermissionPolicyAppReadAll.Id -ObjectId $msi.ObjectId -PrincipalId $msi.ObjectId -ResourceId $graph.ObjectId
