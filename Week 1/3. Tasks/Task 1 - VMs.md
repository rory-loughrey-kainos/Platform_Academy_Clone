# Week 1 - VM Task

## VM SETUP 

### Install and spin up a new Ubuntu (20.04 LTS) VM

Follow the instructions from this Azure Tutorial to create a Ubuntu VM in Azure [https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu]

**VM Azure Config**
- Subscription: 2023-Summer-Platforms-Academy-Belfast
	- Resource Group (Create new)
		- Name: task1-rg-yourname
- VM Name: task1-vm-yourname
- Region: East US
- Availabilty Options: None
- Security Type: Standard
- Image: Ubuntu Server 20.04LTS
- Architecture: x64
- Size: B1ms (1 vCPU / 2GB RAM)
- Auth Type: SSH public key
	- username: azureuser
	- Key pair name: task1-keypair-yourname
- Public inbound port: Allow selected ports
	- SSH (22)
- Disks
	- OS Disk: Standard SSD
- Remaining config leave as is
- Download keypair form pop up and copy to your .ssh directory
	- You might need to restrict access to it after using chmod 400
	
**Make sure you can access the VM via SSH**

	ssh -i ~/.ssh/task1-keypair-yourname.pem azureuser@<vm_public_ip>

### Application Troubleshooting 

1. Install and start Apache Web Server: 
2. Apache should start automatically after machine reboot. 
3. What is the process ID of apache? Why might this be useful? 
ps aux | grep apache*
4. What port is apache running on? 
sudo lsof -i -P -n | grep LISTEN 
5. What interaction can systemd have with apache and why might these be useful? 
6. How can I tell if apache is running correctly through its logs? 
 
### Users and Groups 

1. Create accounts for the following users: 
	- John – UID 1050, default GID 
	sudo adduser -u 1050 John
	- Andrew – no login shell
	sudo adduser  Andrew | grep usermod Andrew -s /sbin/nologin
	- Bob – account locked 
	sudo adduser Bob | grep usermod -l Bob
	- David – default settings 
	sudo adduser David -D
6. Set all passwords to “platform” 
sudo passwd John
7. Turn OFF password expiration / aging 
sudo chage -I -1 -m 0 -M 99999 -E -1 John
8. Create ateam group, add John and Bob to it 
groupadd ateam | grep usermod -a -G ateam John | grep usermod -a -G ateam Bob
9. Create bteam group, add Andrew and David to it 
groupadd bteam | grep usermod -a -G bteam David | grep usermod -a -G bteam Andrew
10. Allow Bob sudo access 
usermod -aG sudo Bob
11. Who else is allowed sudo 
root
12. What is sudo? 
elivated permissions
 
### PARTITIONS 

1. Create a /share directory 
     sudo mkdir /home/share
	* Root should be the owner of group ateam 
	sudo chgrp ateam /home/share
	* Root and ateam should have read write and execute access 
	  sudo chmod 770 /home/share
	* Others are prohibited to access /share dir 
	sudo chown root:ateam share
	* All files created under /share should inherit ateam group (SGID) 
 
2. Create a new partition: 
	* 1G size 
	* ext4 file system. 
	* mount under /share/data

3. Create a 100MB SWAPFILE. 
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

