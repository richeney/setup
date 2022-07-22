# Setup

## Ubuntu 20.04

* [Install WSL](https://aka.ms/installwsl2)

    Open PowerShell in Administrator mode.

    ```powershell
    wsl --install
    ```

* Customise

    My personal bootstrap for a vanilla WSL2 installation of the Ubuntu 20.04 distro from the Microsoft Store.

    ```bash
    bash <(curl -sSL https://raw.githubusercontent.com/richeney/setup/master/bootstrap.sh)
    ```

## Windows

* Login to the Windows Store using your Microsodft ID
* Update [winget](https://docs.microsoft.com/windows/package-manager/winget/)
* Update [winget settings](https://aka.ms/winget-settings)

    Open PowerShell in Administrator mode.

    ```powershell
    winget settings
    ```

* Paste custom settings

    ```json
    {
        "$schema": "https://aka.ms/winget-settings.schema.json",
        "source": {
           "autoUpdateIntervalInMinutes": 5
        },
        "visual": {
            "progressBar": "rainbow"
        },
        "installBehavior": {
            "preferences": {
                "scope": "user",
                "locale": [ "en-GB", "en-US" ]
            }
        }
    }
    ```

* Update source

     ```powershell
     winget source update
     ```

* Install software

    ```powershell
    winget install "Git.Git" --accept-source-agreements --accept-package-agreements
    winget install "GitHub.cli"
    winget install "Microsoft.DotNet.Runtime.6" --silent
    winget install "Microsoft.DotNet.Runtime.5" --silent
    winget install "Microsoft.VC++2015-2022Redist-x64" --silent
    winget install "OneNote for Windows 10" --source msstore --accept-package-agreements
    winget install "Visual Studio Code" --source msstore --accept-package-agreements
    winget install "PowerToys" --source msstore --accept-package-agreements
    winget install "ShareX" --source msstore --accept-package-agreements
    winget install "PowerToys" --source msstore --accept-package-agreements
    ## winget install "EarTrumpet" --source msstore --accept-package-agreements
    ## winget install "NVIDIA Control Panel" --source msstore --accept-package-agreements
    ## winget install "Nvidia.GeForceExperience"
    winget install "Logitech.GHUB"
    winget install "Logitech.LogiTune"
    winget install "Logitech.Options"
    winget install "Netflix" --accept-package-agreements
    winget install "Amazon Prime" --accept-package-agreements
    winget install "Disney+" --accept-package-agreements
    winget install "Tidal" --source msstore --accept-package-agreements
    winget install "Microsoft.Powershell" --source winget
    ```

    Most of these will require authentication credentials and/or further configuration.

* Go back into Windows Store, click on Library (bottom left) then Update All
* Modify Startup apps in settings
* Update [Zorloo driver](https://www.zorloo.com/download)

## Add the Az module

* Reopen Windows Terminal
* Open PowerShell 7

    ```powershell
    pwsh
    ```

* Trust the PSGallery

    ```powershell
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    ```

* Install the module

    ```powershell
    Install-Module Az -Force
    ```

    There is usually an older version (e.g. 4.6.1) of the module installed.

* Import the module

    ```powershell
    Import-Module Az
    ```


## Customisation

* Settings in Windows 11
    * Systems > Multi-Tasking
        * Desktops - Show all open windows --> On all desktops
        * Alt-Tab - Open Windows and 3 most recent tabs
        * Title bar shake: toggle on
    * Bluetooth & Devices > Touchpad - set three finger gestures to switch desktops
* Settings in Windows Terminal
    * Add the Relaxed theme to the JSON

    ```json
            {
                "background": "#282828",
                "black": "#282828",
                "blue": "#6A8799",
                "brightBlack": "#616161",
                "brightBlue": "#7EAAC7",
                "brightCyan": "#ACBBD0",
                "brightGreen": "#A0AC77",
                "brightPurple": "#B06698",
                "brightRed": "#BC5653",
                "brightWhite": "#F7F7F7",
                "brightYellow": "#EBC17A",
                "cursorColor": "#FFFFFF",
                "cyan": "#C9DFE1",
                "foreground": "#D9D9D9",
                "green": "#909D63",
                "name": "Relaxed",
                "purple": "#B06598",
                "red": "#BC5653",
                "selectionBackground": "#FFFFFF",
                "white": "#D9D9D9",
                "yellow": "#EBC17A"
            }
    ```

    * Settings
        * Appearance - Use acrylic in the tab row - toggle on
        * Default > Appearance - Color scheme = Relaxed

## Recover files from old WSL2 installs

OK, so you've refreshed Windows and then remembered that you've lost a specific file or directory from your old WSL2 environment. Here's how to find the file and [mount it in WSL](https://docs.microsoft.com/windows/wsl/wsl2-mount-disk#mount-a-vhd-in-wsl).

This needs Hyper-V enabled.

### Enable Hyper-V

1. Open Powershell with Administrator privileges
1. Enable Hyper-V

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
    ```

1. Reboot

### Mount the drive

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
