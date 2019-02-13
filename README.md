## BIGIP F5 Upgrade Assistant v1.

Objective : Below snippet will show the total no of objects, their availability status , states before and after upgrade . Any change in all of those parameters will displayed over the terminal screen . Also it will mention what changed and reason for it in side by side
pattern ...

Problem This Tool Solves :

Will be a little help for you in Pre & Post Upgrade Tasks.
Automated way to get all above listed stuff to be done in couple of seconds.
It will do line by line comparison and display the files in side by side pattern under the same TTY session screen.

Existing challenges : Upgrading F5 device with lot of Virtual Servers and Wide IPs running in different partitions.

How do we know if we have same number of virtual servers , pools , pool members etc after upgrade ?
How do we know if we have same number of active virtual servers , pool members etc after upgrade ?
How many of them are in disabled state ?
If any change happened after upgrade how to check which one are affected and what’s the reason behind it ? 

Availale Solutions : 

Network Map is an option.However, network map is only for LTM . Also that is a map that start from a virtual server, so if you have a pool that is not linked to a virtual server that will not count in the totals.

You can take a print screen of the statistics before the upgrade and compare after the upgrade.

Settings adjustments for Terminal Clients :

During testing it has been noted that sometimes garbled screen comes when different terminal clients were used for ANSI characters

For Secure CRT Version 8.1.1

Go to Options -> Global Options -> Edit Default Settings -> Emulation -> Terminal  : Linux & Check the ANSI Color

For Secure CRT Version 7.0.3

Go to Options -> Global Options -> Edit Default Settings -> Emulation -> Terminal  : Xterm & Check the ANSI Color

For Putty Release 0.70 

Go to Window -> Translation -> Remote Character Set -> DEC-MCS

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
How to Use Upgrade Assistant v1.0 :

In the F5 device, move the file name Upgrade_Assistant_v1.0.sh in /shared/tmp, as /shared is shared between all volumes. Files placed in it are remain intact after reboots or upgrades.

Change the permissions to run this file by using below command :

chmod u+x Upgrade_Assistant_v1.0.sh

Execute the script:

./Upgrade_Assistant_v1.0.sh
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
