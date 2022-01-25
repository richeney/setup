# 

## Ubuntu 20.04

* [Install WSL](https://aka.ms/installwsl2) 

    Open PowerShell in Administrator mode.

    ```powershell
    wsl --install
    ```

* Customise

    My personal bootstrap for a vanilla WSL2 installation of the Ubuntu 20.04 distro from the Microsoft Store.

    ```bash
    bash <(curl -sSL https://raw.githubusercontent.com/richeney/ubuntu/master/bootstrap.sh)
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
    winget install "Visual Studio Code" --source msstore --accept-package-agreements
    winget install PowerToys --source msstore --accept-package-agreements
    winget install ShareX --source msstore --accept-package-agreements
    winget install EarTrumpet --source msstore --accept-package-agreements
    winget install Nvidia.GeForceExperience
    winget install Logitech.GHUB
    winget install Logitech.LogiTune
    winget install Logitech.Options
    ```
    
 * Update Zorloo driver

    Download from <https://www.zorloo.com/download> and verify. Update if need be.
