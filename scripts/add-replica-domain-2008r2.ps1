if ((gwmi win32_computersystem).partofdomain -eq $false) {

  Write-Host 'Installing RSAT tools'
  Import-Module ServerManager
  Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter

  Write-Host 'Creating domain controller'
  # Disable password complexity policy
  secedit /export /cfg C:\secpol.cfg
  (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
  secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
  rm -force C:\secpol.cfg -confirm:$false

  # Set administrator password
  $computerName = $env:COMPUTERNAME
  $adminPassword = "vagrant"
  $adminUser = [ADSI] "WinNT://$computerName/Administrator,User"
  $adminUser.SetPassword($adminPassword)

  $PlainPassword = "P@ssw0rd"
  $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

  # AD Replica Windows Server 2012 R2
  dcpromo /unattend `
    /SafeModeAdminPassword:$SecurePassword `
    /CreateDnsDelegation:No `
    /DNSOnNetwork:No `
    /NewDomain:Tree `
    /UserName:"Administrator" `
    /Password:"vagrant" `
    /UserDomain:"DOMAIN" `
    /ReplicaOrNewDomain:Replica `
    /ReplicaDomainDNSName:"domain.alt" `
    /ConfirmGC:Yes `
    /ParentDomainDNSName:"domain.alt" `
    /InstallDns:Yes `
    /DatabasePath:"C:\Windows\NTDS" `
    /LogPath:"C:\Windows\NTDS" `
    /SysvolPath:"C:\Windows\SYSVOL" `
    /RebootOnCompletion:Yes
}
