linux-netinstall
================

Automatically install Ubuntu 13.10 from PXE

- Copy the entry in pxelinux.cfg/default to the pxelinux.cfg/default file in the TFTP root folder.
- Host late_command.sh and preseed.cfg somewhere accessible over http
- In pxelinux.cfg/default, adjust web-location of preseed.cfg
- In preseed.cfg, adjust web-location of late_command.sh
- Copy netboot folder of Ubuntu distribution to the TFTP share

Enjoy! Installation should be fully automated.
