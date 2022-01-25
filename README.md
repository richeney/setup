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
                "scope": "user"
            }
        }
    }
    ```

* Update source

     ```powershell
     winget source update
     ```

* Install

    ```powershell
    winget install Git.Git
    winget install GitHub.cli
    winget install "Visual Studio Code" --source msstore --accept-package-agreements
    winget install PowerToys --source msstore --accept-package-agreements
    winget install ShareX --source msstore --accept-package-agreements
    winget install EarTrumpet --source msstore --accept-package-agreements
    winget install "NVIDIA Control Panel" --source msstore --accept-package-agreements
    winget install Nvidia.GeForceExperience
    winget install Logitech.GHUB
    winget install Logitech.LogiTune
    winget install Logitech.Options
    winget install Netflix --accept-package-agreements
    winget install Amazon Prime --accept-package-agreements
    winget install Netflix --accept-package-agreements
    winget install "Amazon Prime" --accept-package-agreements
    winget install Disney+ --accept-package-agreements
    winget install Tidal --source msstore --accept-package-agreements
    winget install --id Microsoft.Powershell --source winget
    ```

    Most of these will require authentication credentials and/or further configuration.

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

* Open the settings in Windows Terminal in JSON
* Add the Relaxed theme

    ```json
            {
                "background": "#353A44",
                "black": "#151515",
                "blue": "#6A8799",
                "brightBlack": "#636363",
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
