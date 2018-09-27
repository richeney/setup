# Read Me

The ubuntu.zip file was created manually using the following command:

```bash
cd ~
zip -r -x@zipExclude --encrypt --symlinks /mnt/c/Users/richeney/git/ubuntu/ubuntu.zip .
```

It will prompt for a password for the encryption.

Unzip with

```bash
unzip /path/to/ubuntu.zip
```

The current zipExclude file is within the tarfile.  Initial version:

```yaml
~$ cat zipExclude
.azure/cliextensions/*
.azure/log/*
.azure/telemetry/*
.bundle/*
.cache/*
.kube/cache/*
.linuxbrew/*
.npm/*
git/*
userprofile/*
```

Some files in the area have been created automatically using cron jobs:

```yaml
00 12 * * * dpkg-query -f '${binary:Package}\n' -W > ~/aptPackageList
00 12 * * * grep "url =" /mnt/c/Users/richeney/git/*/.git/config | awk '{print $NF}' | sort > ~/gitRepoList
00 12 * * * crontab -l > ~/crontab
```
