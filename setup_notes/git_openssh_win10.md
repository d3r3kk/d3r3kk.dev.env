# Setting up Git + OpenSSH on Windows 10

There has been some problems recently with setting up git over ssh using the shipped OpenSSH that comes with Windows 10. These notes will hopefully help out with that.

# OpenSSH

Get this by clicking the Windows key, then type "Add optional features" 
- add the 'OpenSSH Client'

Once you've added the feature (and if necessary, rebooted your machine), enable the service such that it starts Automatically on startup.

There is a bug where the installed OpenSSH service doesn't configure ssh-agent correctly. One workaround to this issue was found on [the OpenSSH github site here](https://github.com/Microsoft/OpenSSH/find-this-issue-and-add-link-derek). Basically, open a Powershell window as Administrator and issue this command:

'''
sc.exe create sshd binPath=C:\Windows\System32\OpenSSH\ssh.exe
'''

# Git

Git is very easy to install on Windows. [Simply go here to the Git site and download the latest version](https://git-scm.org/), then install it.

Set up your user name and email - this is something easy to forget but will confound you on your first submit.

Open a powershell window and type the following:

```
git config --global --add user.name "My Name"
git config --global --add user.email "my_email@my_email_service.com"
```

Configure git to run with the installed version of OpenSSH (it does try to use the version of ssh.exe it ships with for some reason). Do this by setting your global git config once more:

```
git config --global --add core.sshCommand "'C:\\Windows\\System32\\OpenSSH\\ssh.exe'"
```

# Your credentials

Now it's time to set up your own SSH keys. To do this, open a Powershell window and issue the following command, and enter :

```
ssh-keygen -t rsa -b 2048 -C [enter_a_note_about_this_cert_such_as("$Env:COMPUTERNAME cert for work")]
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\user/.ssh/id_rsa): [press_enter]
Enter passphrase (empty for no passphrase): [do_use_a_passphrase_please]
Enter same passphrase again: [repeat_your_top_secret_passphrase]
Your identification has been saved in C:\Users\user\.ssh\id_rsa.
Your public key has been saved in C:\Users\user\.ssh\id_rsa.pub.
The key fingerprint is:
SHA256:ABCDEF01234567890ABCDEF0123456789+0123456789 MY_COMPUTER_NAME cert for work
The key's randomart image is:
+---[RSA 2048]----+
|     .=X@OEX++   |
|    . +_O== o .  |
|     o+o==       |
|      o*..       |
|       +S        |
|    . .+==       |
|     o(.o        |
|    ..  ....     |
|     .. ...      |
+----[SHA256]-----+
```

You will need the content of the public key file to add your key to the Github (or AzDO) environment. Do this by simply issuing the 'cat ~/.ssh/id_rsa.pub' command in your Powershell window.

Log into your github/AzDO account and visit the Settings->Security->SSH Keys section, and add this key by giving it a name and pasting the contents of your public (id_rsa.pub) key into the given window.

Last step here is to add the new ssh key to your ssh-agent, so that you won't have to type the passphrase in all the time. Open a Powershell window and issue this command:

```
ssh-add
Enter passphrase for C:\Users\user\.ssh\id_rsa: [your_super_secret_passphrase]
Identity added: C:\Users\user\.ssh\id_rsa (C:\Users\user\.ssh\id_rsa)
```

Now you should be able to issue git commands free from entering passphrases, all the while being comforted by the lovely protection of SSH.

