# OpenSSH Docker

An example of how to setup OpenSSH within images.

You may checkout my Dockerfile [here](https://github.com/kar-fai/openssh-docker/blob/master/Dockerfile). 

### Simple Features

* SSH login without password
* Add multiple SSH keys
* Perform validation on input SSH Key
* Query local and public address
* SSH log, eg. login attempts, logged-in, logged-out
* Bash history log from each logged-in user

### Command

```
docker run -ti --rm -p 22:22 karfai/openssh
```

### Sample Output

```
Generating locales...
  en_US.UTF-8... done
Generation complete.
Generating locales...
  en_US.UTF-8... up-to-date
Generation complete.
Enter authorized key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHqT8+4nybv2ACRd0HC28Z/61WMCXyYbVEOo5zpSRiz6gUBJgvgiZpruxHSBLk/4FFSLm+i7Bw0DsgpdXR33v09R2AAqZSZCKbWZ9rXseMYFkRgVlYL8PvaB5oqoaS/BelxPiJuZXpRzXtamF+G0TB8GelRBwbAZ6hwwL26xP11VqNIgng7xKSrJ4fECWrdNWqhQa3e5Z8gZt2hKiKnJwimuVYY0Ctnxvkqfp3C+fOu7Waa+IKc+YEzrszI9Dc4X4Gn2tGP+fCWASdGicIApBrTR0OV0NGRq6c0GVlZX24DH+RRTrgR7FOv3UrmnNRHnZqxuib7aE9uT3g3u8PVUNT userA@machine-A
2048 42:b3:39:90:ac:8a:c0:8d:b3:65:1b:d3:69:a5:bd:46  userA@machine-A (RSA)
Continue add authorized keys? [Y/n] y
[Ctrl+C to cancel] Enter authorized key: ssh-rsa AAAAB3NzaC1yc2EAAAAAAAAAAAAAAAAAAAAAAAAAA/MlQViRi7kSiZtBOtXvRx3x2u0kFRFctMEW7hxnEpRvxpcfkqWNoYn4IQqbUiujdSmxp6GrAyCHoQbFtPD+57MVVSP+uN4ZkwKiwyriXykV1BQtWHubrWHXlQM2PP4Kl4oVlXcNTVy8PkZ5xsselRYUen7wce6u52ZZiGzhaGOtnO82TfSopTDc8cn4ZHwrrQCfvjOSW3xReRLFM4VpqmK5XwLOO7yPEEMtZ91sMQJsAMbNqvbz9atuZLw73Cq4ULGt3oh0G8eeLebsVfsjg6LbLMYpcErDLIKLN4KsrR7qQ/WJRBQHB2Bqr4ttmjR18990Z3wKAxZf userB@machine-B
2048 82:78:4e:00:72:7e:4e:45:df:99:96:4c:fd:43:66:ad  userB@machine-B (RSA)
Continue add authorized keys? [Y/n] y
[Ctrl+C to cancel] Enter authorized key: ^C
Continue add authorized keys? [Y/n] n
 * Starting enhanced syslogd rsyslogd                                            [ OK ] 
 * Starting OpenBSD Secure Shell server sshd                                     [ OK ] 
Local  IP: 172.17.0.2
Public IP: 175.143.160.191
==> /var/log/auth.log <==
Feb 26 18:52:21 7e5bba2ac995 sshd[174]: Server listening on 0.0.0.0 port 22.
Feb 26 18:52:21 7e5bba2ac995 sshd[174]: Server listening on :: port 22.
tail: cannot open '/var/log/commands.log' for reading: No such file or directory

==> /var/log/auth.log <==
Feb 26 18:52:26 7e5bba2ac995 sshd[186]: Accepted publickey for root from 172.17.0.1 port 45658 ssh2: RSA 82:78:4e:00:72:7e:4e:45:df:99:96:4c:fd:43:66:ad
Feb 26 18:52:26 7e5bba2ac995 sshd[186]: pam_unix(sshd:session): session opened for user root by (uid=0)
tail: '/var/log/commands.log' has appeared;  following end of new file

==> /var/log/commands.log <==
Feb 26 18:52:26 7e5bba2ac995 root: root [197]:  [0]
Feb 26 18:52:38 7e5bba2ac995 root: root [197]: echo hello world [0]

==> /var/log/auth.log <==
Feb 26 18:52:41 7e5bba2ac995 sshd[186]: Received disconnect from 172.17.0.1: 11: disconnected by user
Feb 26 18:52:41 7e5bba2ac995 sshd[186]: pam_unix(sshd:session): session closed for user root
...
```
