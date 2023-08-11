# SSH Keys Task

### GitHub

Create yourself a GitHub account using your Kainos Email Address

[https://github.com/](https://github.com/)


### Generating SSH Keys

In order to access SSH in GitHub through your MacBook Terminal, you will need to generate SSH keys.

To do that, open up your preferred terminal and run

	ssh-keygen -t rsa -b 4096 -C "your_email@kainos.com"
	
This command will create a new SSH key using your email as a label. The comment (-c argument) is text appended to the key in your public key file, and is typically used as a label for your key so you know what it is for.

You don't HAVE to use your email - you can use whatever label you see fit... But we'll go for your email in this instance.

You should then see:

	> Generating public/private ALGORITHM key pair.
	
When you're prompted to "Enter a file in which to save the key", you can press Enter to accept the default file location.

	> Enter a file in which to save the key (/Users/YOU/.ssh/id_rsa: [Press enter]

You will then have the option to enter a passphrase to secure your key.


SSH passphrases protect your private key from being used by someone who doesn't know the passphrase. Without a passphrase, anyone who gains access to your computer has the potential to copy your private key.

**If you create a passphrase, make sure to save it in BitWarden, if you lose it, you will no longer be able to access this key!!**

	> Enter passphrase (empty for no passphrase): [Type a passphrase]
	> Enter same passphrase again: [Type passphrase again]

Head into Git and then settings -> SSH and GPG keys

Click the 'New SSH key' button

Give it a name in the 'title' box (such as 'YOURNAME MACBOOK')

Key type is 'Authentication Key'

In your terminal, run:

	pbcopy < ~/.ssh/id_rsa.pub
	
This will copy your public key to your clipboard, paste this into the 'Key' box.

Click 'Add SSH key'