$box = Get-ItemProperty -Path HKLM:SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName -Name "ComputerName"
$box = $box.ComputerName.ToString().ToLower()


#. c:\vagrant\scripts\join-domain.ps1

. c:\vagrant\scripts\addreplica-domain-2008r2.ps1 192.168.38.3
