# Week 1 - VM Task

## VM SETUP 

### Install and spin up a new Ubuntu (20.04 LTS) VM
 
	Make sure you can access the VM via SSH

### Application Troubleshooting 

1. Install and start Apache Web Server: 
2. Apache should start automatically after machine reboot. 
3. What is the process ID of apache? Why might this be useful? 
4. What port is apache running on? 
5. What interaction can systemd have with apache and why might these be useful? 
6. How can I tell if apache is running correctly through its logs? 
 
### Users and Groups 

1. Create accounts for the following users: 
2. John – UID 1050, default GID 
3. Andrew – no login shell 
4. Bob – account locked 
5. David – default settings 
6. Set all passwords to “platform” 
7. Turn OFF password expiration / aging 
8. Create ateam group, add John and Bob to it 
9. Create bteam group, add Andrew and David to it 
10. Allow Bob sudo access 
11. Who else is allowed sudo 
12. What is sudo? 
 
### PARTITIONS 

1. Create a /share directory 
	* Root should be the owner of group ateam 
	* Root and ateam should have read write and execute access 
	* Others are prohibited to access /share dir 
	* All files created under /share should inherit ateam group (SGID) 
 
2. Create a new partition: 
	* 1G size 
	* ext4 file system. 
	* mount under /share/data

3. Create a 100MB SWAP partition. 
	* What would this be useful for? 
	* How much free disk space does the box have?
	* What directory/files are taking up the most space on the system? 
 
### SECURITY 

1. Enable AppArmor
	* What does AppArmor do? 
	* What does the complain setting mean? 
	AppArmor allows applications to take restricted actions and creates a log entry complaining about this. Complain mode is ideal for testing an AppArmor profile before enabling it in enforce mode – you’ll see any errors that would occur in enforce mode.
	* How many network adapters are configured? 
	1
	* What is iptables and what is ufw? 
	iptables - firewall utility in linux 
	ufw - makes life 'easier' with iptables
	* What are the current rules on iptables? 
	accept all
	* What are the current rules on ufw?
	inactive

2.  Make it so only ssh and http from anywhere are allowed to the box.
	sudo ufw allow proto tcp from any to any port 80,443,22
 should you use iptables or ufw?
 both, ufw is easier for quick setup
	* Why might this be useful? 
	ease of use
	* Why might this not be best practice?
	conflicting setup/ multiple firewalls to setup
 
### UPDATES and UPGRADES

1. Update all packages on the VM
update & upgrade
2. Upgrade the VM to the latest releases

