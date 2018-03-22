
# win-stand
(c) Georgy A Bystrenin gkot@altlinux.org Start 16 Janury 2018

## Test infrastructure for AD based on Windows Server

Windows server + client stand based on Vagrant with Virtualbox provider 

./scripts based on:
 * https://github.com/StefanScherer/adfs2/tree/master/scripts
 * https://github.com/TAMUArch/cookbook.windows_ad 
 
Based BOX List:
  * universalvishwa/windows-2008-r2-standard-x64
  * 

DIR List:
   <DIR_NAME> | Description
  * w08r2srv-dc1 | start Forest AD Controller domain.alt
  * w08r2srv-dc2_repl | 2 VM:
     VM <NAME> = Description
            dc = start First Domain Controller domain.alt
          repl = start Replica of Forest Controller domain.alt
  * w08r2srv-dc3_child | 2 VM:
     VM <NAME> = Description
            dc = start Domain Controller domain.alt
          repl = start Domain Controller subdomain child.domain.alt

### Example: Create Domain Controller
Create Forest AD Controller

```sh
 cd w08r2srv-dc1
 vagrant up
```

After that the domain `domain.alt` is up and running at IP address `192.168.38.2`.

## Normal Use
After setting up all boxes, you simply can start and stop the boxes, but the
Domain Controller should be started first and stopped last.

  ```bash
   cd <DIR_NAME>
   vagrant up <NAME>
   vagrant halt <NAME>
``` 

## TODO:
 * Fix w08r2srv-dc4_2Site
 * Fix join to AD Domain w7ProX64-client
