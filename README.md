# Setup

## Ubuntu 20.04

* [Install WSL](https://aka.ms/installwsl2)

    Open PowerShell in Administrator mode. (`Win`+`X`)

    ```powershell
    wsl --install
    ```

    Will need a reboot.

* Customise

    My personal bootstrap for a vanilla WSL2 installation of the Ubuntu 22.04 distro from the Microsoft Store.

    ```bash
    bash <(curl -sSL https://raw.githubusercontent.com/richeney/setup/master/bootstrap.sh)
    ```

* Oh My Posh

    *Not working?*

    ```bash
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
    mkdir ~/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
    unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
    chmod u+rw ~/.poshthemes/*.omp.*
    rm ~/.poshthemes/themes.zip
    wget https://raw.githubusercontent.com/richeney/setup/master/azurecitadel.omp.json -O ~/.poshthemes/azurecitadel.omp.json
    ```


## Windows

* ⚠️ **Login to the Windows Store using your Microsoft ID**
* Install [App Installer](https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab)

    This includes the production version of winget. ([Alternative installs](https://docs.microsoft.com/windows/package-manager/winget/).)

* Update [winget settings](https://aka.ms/winget-settings)

    PowerShell in Administrator mode.

    ```powershell
    winget settings
    ```

    And choose Notepad, just this once.

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

* List installed apps

   ```powershell
   winget list
   ```

* Uninstall apps

    ```powershell
    ## winget uninstall "Cortana"
    winget uninstall "MSN Weather"
    winget uninstall "Solitaire & Casual Games"
    ## winget uninstall "Mixed Reality Portal"
    ## winget uninstall "Skype"
    ## winget uninstall "Windows Maps"
    ## winget uninstall "Xbox Game Bar Plugin" ## the overlay conflicts with the mic
    ## winget uninstall "Xbox Game Bar"
    ## winget uninstall "OneNote for Windows 10"
    ## winget uninstall "Microsoft OneNote - en-gb" # removing all of office?
    ## winget uninstall MicrosoftTeams_8wekyb3d8bbwe
    ## winget uninstall Microsoft.Teams
    ## winget uninstall "Mail and Calendar"
    ## winget uninstall "Teams Machine-Wide Installer"
    ```

* Install software

    ⚠️ Check the desktop - Reset my PC now adds a list of the software that was lost. Update the winget list below.

    ```powershell
    winget install "Git.Git" --accept-source-agreements --accept-package-agreements --silent
    winget install "GitHub.cli" --silent
    winget install --exact --id "Microsoft.AzureCLI" --silent
    ## winget install "Microsoft.DotNet.Runtime.6" --silent
    ## winget install "Microsoft.DotNet.Runtime.5" --silent
    ## winget install "Microsoft.VC++2015-2022Redist-x64" --silent
    winget install --exact --id XP9KHM4BK9FZ7Q --source msstore --accept-package-agreements # Visual Studio Code
    ## winget install "Microsoft Remote Desktop" --source msstore --accept-package-agreements
    winget install "PowerToys" --source msstore --accept-package-agreements
    ## winget install "ShareX" --source msstore --accept-package-agreements
    ## winget install "Ambie" --source winget
    ## winget install "EarTrumpet" --source msstore --accept-package-agreements
    ## winget install "NVIDIA Control Panel" --source msstore --accept-package-agreements
    ## winget install "Nvidia.GeForceExperience"
    ## winget install "Logitech.GHUB"
    winget install "Logitech.LogiTune"
    winget install --exact --id "Logitech.OptionsPlus"
    winget install "HP Smart" --source msstore --accept-package-agreements
    winget install "Netflix" --accept-package-agreements
    winget install "Amazon Prime" --accept-package-agreements
    winget install "Disney+" --accept-package-agreements
    winget install "Tidal" --source msstore --accept-package-agreements
    winget install --exact --id 9NKSQGP7F2NH --source msstore --accept-package-agreements # WhatsApp
    winget install --id Microsoft.Powershell --source winget
    ```

    Most of these will require authentication credentials and/or further configuration.

* Update all packages

   ```powershell
   winget upgrade --silent --all
   ```

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

## Settings in Windows Terminal

In lieu of [roaming settings.json](https://github.com/microsoft/terminal/issues/2933).

* actions array

    ```json
    [{"command":{"action":"copy","singleLine":false},"keys":"ctrl+c"},{"command":"paste","keys":"ctrl+v"},{"command":"find","keys":"ctrl+shift+f"},{"command":{"action":"splitPane","split":"auto","splitMode":"duplicate"},"keys":"alt+shift+d"},{"command":"toggleFocusMode","keys":"ctrl+f"}]
    ```

* profiles.defaults object

    ```json
    {"colorScheme":"Relaxed","font":{"face":"Cascadia Mono"},"opacity":85,"scrollbarState":"hidden","useAcrylic":true}
    ```

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

* Re-prettify with  `CTRL`+`ALT`+`M` if you have JSON Tools in vscode.

## Finishing up

OK, should be done. Perhaps some authentication to do within the winget installed apps, but nothing major.

Check out the [recover](./RECOVER.md) if you need to get back some files from the pre-refresh WSL environment.
