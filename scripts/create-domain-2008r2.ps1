param ([String] $ip)

$subnet = $ip -replace "\.\d+$", ""

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

  $PlainPassword = "vagrant" # "P@ssw0rd"
  $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

  # AD Forest Windows Server 2012 R2 DomainLevel/ForestLevel 2008/2008
   dcpromo /unattend `
    /SafeModeAdminPassword:$SecurePassword `
    /CreateDnsDelegation:No `
    /NewDomain:forest `
    /DomainLevel:4 `
    /ForestLevel:4 `
    /NewDomainDNSName:"domain.alt" `
    /DomainNetbiosName:"DOMAIN" `
    /ReplicaOrNewDomain:"domain" `
    /InstallDns:Yes `
    /DatabasePath:"C:\Windows\NTDS" `
    /LogPath:"C:\Windows\NTDS" `
    /SysvolPath:"C:\Windows\SYSVOL" `
    /RebootOnCompletion:No

  $newDNSServers = "8.8.8.8", "4.4.4.4"
  $adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -And ($_.IPAddress).StartsWith($subnet) }
  if ($adapters) {
    Write-Host Setting DNS
    $adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}
  }
}