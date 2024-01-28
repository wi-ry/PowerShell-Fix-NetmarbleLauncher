# PowerShell-Fix-NetmarbleLauncher

Update: Verified this is still working with launcher version 1.02.010.

Fixes a bug in the Netmarble Launcher for Ni No Kuni: Cross Worlds and The King of Fighers All Star

Basically, the code for getting the available disk space in the Netmarble launcher is broken (As of v0.2.9 anyway). This script loads the config.json file from `$env:APPDATA/Netmarble Launcher/config.json`, makles a backup of the original config file, adds or updates the available disk space section, then saves the new version. This should be all you need to fix this silly bug:

![image](https://user-images.githubusercontent.com/9650258/182047075-5113e860-c3d5-44b3-8fef-f964461ece0b.png)

## Instructions
1. Reinstall the Netmarble Launcher with default settings
2. Close the launcher and exit it from the system tray
3. Save the .ps1 script in this repo
4. Run the script with PowerShell (e.g. `.\Fix-NetmarbleLauncher.ps1`)
5. You should see output like this:
```
PS W:\Desktop> .\Fix-NetmarbleLauncher.ps1
Welcome to Fix-NetmarbleLauncher... Lets fix the Netmarble Launcher!
 - Made a backup of your existing file to C:\Users\User\AppData\Roaming/Netmarble Launcher/config.json.backup_20220731T2204559969Z
 - Adding available disk space for C drive to launcher config...
All done. Please reopen the launcher now and install your game!
Press any key to exit
```
6. Reopen the Launcher and press Install
7. Enjoy!
