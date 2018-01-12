param ([String] $dns)

$name = "Local Area Connection"

if ($dns) {
  Write-Host "Set DNS server address to $dns of interface $name"
  & netsh.exe interface ipv4 add dnsserver "$name" address=$dns
}
