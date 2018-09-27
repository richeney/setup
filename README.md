# Read Me

The ubuntu.tar.gz file was created using the following command:

```bash
cd ~
tar -czp --exclude-ignore=tarExclude -f git/ubuntu/ubuntu.tar.gz .
```

The current tarExclude file is within the tarfile.  Initial version

```yaml
.azure/cliextensions
.azure/log
.azure/telemetry
.bundle
.cache
.kube/cache
.linuxbrew
#.local
.npm
git
userprofile
```

Some files in the area have been created automatically using cron jobs:

```bash
00 12 * * * dpkg-query -f '${binary:Package}\n' -W > ~/aptPackageList
00 12 * * * grep "url =" /mnt/c/Users/richeney/git/*/.git/config | awk '{print $NF}' | sort > ~/gitRepoList
00 12 * * * crontab -l > ~/crontab
05 12 * * * cd ~; tar -czp --exclude-ignore=tarExclude -f git/ubuntu/ubuntu.tar.gz .
```