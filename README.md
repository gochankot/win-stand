# ALT Stand for testing AD
Windows server + client stand based on Vagrant with Virtualbox provide

Using boxes:
* https://app.vagrantup.com/universalvishwa/windows-2008-r2-standard-x64
* https://app.vagrantup.com/universalvishwa/windows-7-professional-x64

Supported vagrant version - 2.0.1 ([Download x64](
https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm))
or [later](https://www.vagrantup.com/downloads.html)

Initial steps:
```bash
git clone https://github.com/gochankot/win-stand
cd win-stand/
Cd <DIR>*
vagrant up
```
### DIR LIST:
* w08r2srv-dc1 - 1 First Controler domain.alt
* w08r2srv-dc2_repl - First + replica Controlers domain.alt
* w08r2srv-dc3_child - 2 First controlers domain.alt + child.domain.alt
* W08r2srv-RSAT - Windows Server 2008 R2 Clinet + RSAT
* w7ProX64-client - Windows 7 Client + RSAT
