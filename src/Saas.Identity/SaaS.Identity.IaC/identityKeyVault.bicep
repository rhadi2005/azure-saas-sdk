// Parameters
//////////////////////////////////////////////////
@description('The name of the Key Vault.')
param keyVaultName string

@description('The location for all resources.')
param location string

@description('The name of the Azure AD B2C Domain Key Vault Secret.')
param azureAdB2cDomainSecretName string = 'permissions-AzureAdB2C--Domain'

@description('The value of the Azure AD B2C Domain Key Vault Secret.')
param azureAdB2cDomainSecretValue string

@description('The name of the Azure AD B2C Instance Key Vault Secret.')
param azureAdB2cInstanceSecretName string = 'permissions-AzureAdB2C--Instance'

@description('The value of the Azure AD B2C Instance Key Vault Secret.')
param azureAdB2cInstanceSecretValue string

@description('The name of the Azure AD B2C Tenant Id Key Vault Secret.')
param azureAdB2cTenantIdSecretName string = 'permissions-AzureAdB2C--TenantId'

@description('The value of the Azure AD B2C Tenant Id Key Vault Secret.')
param azureAdB2cTenantIdSecretValue string
@description('The name of the Azure AD B2C Permissions Api Client Id Key Vault Secret.')
param azureAdB2cPermissionsApiClientIdSecretName string = 'permissions-AzureAdB2C--ClientId'

@description('The value of the Azure AD B2C Permissions Api Client Id Key Vault Secret.')
param azureAdB2cPermissionsApiClientIdSecretValue string

@description('The name of the Azure AD B2C Permissions Api Client Id Key Vault Secret.')
param azureAdB2cPermissionsApiClientSecretSecretName string = 'permissions-AzureAdB2C--ClientSecret'

@description('The value of the Azure AD B2C Permissions Api Client Secret Key Vault Secret.')
param azureAdB2cPermissionsApiClientSecretSecretValue string

@description('The name of the Permissions Api Api Key Key Vault Secret.')
param permissionsApiApiKeySecretName string = 'permissions-AppSettings--ApiKey'

@description('The value of the Permissions Api Api Key Key Vault Secret.')
param permissionsApiApiKeySecretValue string

@description('The name of the Permissions SQL Connection String Key Vault Secret.')
param permissionsSqlConnectionStringSecretName string = 'permissions-ConnectionStrings--PermissionsContext'

@description('The value of the Permissions SQL Connection String Key Vault Secret.')
param permissionsSqlConnectionStringSecretValue string

// Resource - Key Vault
//////////////////////////////////////////////////
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    enabledForTemplateDeployment: true
    enableSoftDelete: false
    // softDeleteRetentionInDays: 7
    // enablePurgeProtection: false
    tenantId: subscription().tenantId
    publicNetworkAccess: 'enabled'
    accessPolicies: []
  }
}

// Resource - Key Vault - Secret - Permissions Api Api Key 
//////////////////////////////////////////////////
resource permissionsApiSslThumbprintSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: permissionsApiApiKeySecretName 
  properties: {
    value: permissionsApiApiKeySecretValue 
  }
}

// Resource - Key Vault - Secret - Permissions SQL Connection String
//////////////////////////////////////////////////
resource permissionsSqlConnectionStringSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: permissionsSqlConnectionStringSecretName
  properties: {
    value: permissionsSqlConnectionStringSecretValue
  }
}

// Resource - Key Vault - Secret - Azure AD B2C Instance
//////////////////////////////////////////////////
resource azureAdB2cInstanceSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: azureAdB2cInstanceSecretName
  properties: {
    value: azureAdB2cInstanceSecretValue
  }
}

// Resource - Key Vault - Secret - Azure AD B2C Domain
//////////////////////////////////////////////////
resource azureAdB2cDomainSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: azureAdB2cDomainSecretName
  properties: {
    value: azureAdB2cDomainSecretValue
  }
}

// Resource - Key Vault - Secret - Azure AD B2C Tenant Id
//////////////////////////////////////////////////
resource azureAdB2cTenantSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: azureAdB2cTenantIdSecretName
  properties: {
    value: azureAdB2cTenantIdSecretValue
  }
}

// Resource - Key Vault - Secret - Azure AD B2C Permissions API Client Id
//////////////////////////////////////////////////
resource azureAdB2cPermissionsApiClientIdSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: azureAdB2cPermissionsApiClientIdSecretName
  properties: {
    value: azureAdB2cPermissionsApiClientIdSecretValue
  }
}
// Resource - Key Vault - Secret - Azure AD B2C Signup Admin Client Secret
//////////////////////////////////////////////////
resource azureAdB2cPermissionsApiClientSecretSecret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: keyVault
  name: azureAdB2cPermissionsApiClientSecretSecretName
  properties: {
    value: azureAdB2cPermissionsApiClientSecretSecretValue
  }
}


// Outputs
//////////////////////////////////////////////////
output keyVaultId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
