$ErrorActionPreference = 'Stop'
$blobDataContributor = $env:BlobData
$blobQueueContributor = $env:BlobQueue
$sub = $env:SubscriptionId


$storageAccount = Get-AzStorageAccount -ResourceGroupName $env:ResourceGroupName -AccountName $env:StorageAccountName

# Enable the static website feature on the storage account.
$ctx = $storageAccount.Context
Enable-AzStorageStaticWebsite -Context $ctx -IndexDocument $env:IndexDocumentPath

# Add roles to the Service Principal account so uploads so deploy task can upload UI into $web
$context = Get-AzContext

New-AzRoleAssignment -ObjectId $context.Account.id -RoleDefinitionName $blobDataContributor -Scope "/subscriptions/${sub}/resourceGroups/${env:ResourceGroupName}/provider/Microsoft.Storage/storageAccounts/${env:StorageAccountName}"
New-AzRoleAssignment -ObjectId $context.Account.id -RoleDefinitionName $blobQueueContributor -Scope "/subscriptions/${sub}/resourceGroups/${env:ResourceGroupName}/provider/Microsoft.Storage/storageAccounts/${env:StorageAccountName}"
