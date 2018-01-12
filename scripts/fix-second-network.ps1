param ([String] $ip, [String] $dns)

$name="Local Area Connection"

$subnet = $ip -replace "\.\d+$", ""

  #Write-Host "Set IP address to $ip of interface $name"
  #& netsh.exe int ip set address $name static $ip 255.255.255.0 "$subnet.1"

  if ($dns) {
    Write-Host "Set DNS server address to $dns of interface $name"
    & netsh.exe interface ipv4 add dnsserver $name address=$dns index=2
  }
#} else {
#  Write-Error "Could not find a interface $name"
#}
