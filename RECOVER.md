# Recover files from old WSL2 installs

OK, so you've refreshed Windows and then remembered that you've lost a specific file or directory from your old WSL2 environment. Here's how to find the file and [mount it in WSL](https://docs.microsoft.com/windows/wsl/wsl2-mount-disk#mount-a-vhd-in-wsl).

This needs Hyper-V enabled.

## Enable Hyper-V

1. Open Powershell with Administrator privileges
1. Enable Hyper-V

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
    ```

1. Reboot

## Mount the drive

1. Open Powershell with Administrator privileges
1. Find the old ext4.vhdx file

    ```powershell
    Get-ChildItem -Path C:\Windows.old\Users\$([Environment]::UserName)\AppData\Local\Packages -Include ext4.vhdx -File -Recurse -ErrorAction SilentlyContinue
    ```

    Example output:

    ```text

        Directory: C:\Windows.old\Users\richeney\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState

    Mode                 LastWriteTime         Length Name
    ----                 -------------         ------ ----
    -a---          25/01/2022    09:24    34395389952 ext4.vhdx

    ```

1. Set a filename variable

    ```powershell
    $disk = (Get-ChildItem -Path C:\Windows.old\Users\$([Environment]::UserName)\AppData\Local\Packages -Include ext4.vhdx -File -Recurse -ErrorAction SilentlyContinue).FullName
    ```

    > This command works on the basis that you have found only one file. If you have discover than one then set manually or change the path value to ensure it is unique.

1. Show the filename

    ```powershell
    echo $disk
    ```

1. Mount the drive and show the path

    ```powershell
    Write-Output "\\.\PhysicalDrive$((Mount-VHD -Path $disk -PassThru | Get-Disk).Number)"
    ```

    Example output:

    ```powershell
    \\.\PhysicalDrive3
    ```

1. Show the drives

    ```powershell
    GET-CimInstance -query "SELECT * from Win32_DiskDrive"
    ```

    Example output

    ```text

    DeviceID           Caption                    Partitions Size          Model
    --------           -------                    ---------- ----          -----
    \\.\PHYSICALDRIVE0 SAMSUNG MZVLB1T0HBLR-000MV 4          1024203640320 SAMSUNG MZVLB1T0HBLR-000MV
    \\.\PHYSICALDRIVE3 Microsoft Virtual Disk     0          274872407040  Microsoft Virtual Disk
    ```

1. Mount in WSL

    ```powershell
    wsl --mount \\.\PHYSICALDRIVE3
    ```

    > Change to your drive path if different.

    Example output:

    ```text
    The disk \\.\PHYSICALDRIVE3 was successfully mounted under the name 'PHYSICALDRIVE3'. The mountpoint can be found under the path pointed to by the automount setting (default: /mnt/wsl).
    To unmount and detach the disk, run 'wsl --unmount \\.\PHYSICALDRIVE3'.
    ```

1. In your WSL distro

    ```bash
    df -k --type=ext4
    ``

    Example output:

    ```text
    Filesystem     1K-blocks     Used Available Use% Mounted on
    /dev/sdc       263174212  5007124 244728932   3% /
    /dev/sdd       263174212 27652224 222083832  12% /mnt/wsl/PHYSICALDRIVE3
    ````

1. Change to your old home directory

    ```bash
    cd /mnt/wsl/PHYSICALDRIVE?/$HOME
    ```

1. Copy out files as required
1. Move out of the file mount

    ```bash
    cd ~
    ```

1. Return to Powershell
1. Unmount

    ```powershell
    wsl --unmount \\.\PHYSICALDRIVE3
    ```
