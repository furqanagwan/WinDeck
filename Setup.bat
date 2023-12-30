@echo off
:menu
cls
echo WinDeck:
echo 1. Install Steam Deck Drivers
echo 2. Install Steam
echo 3. Install WeMod
echo 4. Install SteamOS background wallpapers
echo 5. Exit

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto install_drivers
if "%choice%"=="2" goto install_steam
if "%choice%"=="3" goto install_wemod
if "%choice%"=="4" goto install_steamOS_backgrounds
if "%choice%"=="5" goto exit

echo Invalid choice. Please enter a number from 1 to 5.
pause
goto menu

:install_drivers
echo Installing Steam Deck Drivers...
call Programs\Drivers\install.bat
pause
goto menu

:install_steam
echo Installing Steam...
call Programs\Steam\install.bat
powershell -command "& {Start-Process -filepath 'Steam\install.bat' -verb runas}"
pause
goto menu

:install_wemod
echo Installing WeMod...
call Programs\WeMod\install.bat
pause
goto menu

:install_steamOS_backgrounds
powershell -command "& {Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}

"@
# Set the path for the Wallpapers folder on Windows 11
$wallpapersFolder = "$env:USERPROFILE\Wallpapers"

# Check if the Wallpapers folder exists, create it if not
if (-not (Test-Path $wallpapersFolder)) {
    New-Item -ItemType Directory -Force -Path $wallpapersFolder
}

# Loop through SteamOS background images (SteamOS-1.jpg to SteamOS-14.jpg)
for ($i=1; $i -le 14; $i++) {
    $backgroundPath = "Assets\SteamOS\Background\SteamOS-$i.jpg"
    $destinationPath = Join-Path $wallpapersFolder (Split-Path $backgroundPath -Leaf)

    # Copy the SteamOS image to the Wallpapers folder
    Copy-Item -Path $backgroundPath -Destination $destinationPath -Force
}

# Set the wallpaper using SystemParametersInfo
[Wallpaper]::SystemParametersInfo(0x0014, 0, "$wallpapersFolder\SteamOS-1.jpg", 0x02)}"
pause
goto menu

:exit
echo Exiting the menu.
pause
exit
