@echo off
:menu
cls
echo Menu:
echo 1. Install Steam Deck Drivers
echo 2. Install Steam
echo 3. Install WeMod
echo 4. Exit

set /p choice=Enter your choice (1-4): 

if "%choice%"=="1" goto install_drivers
if "%choice%"=="2" goto install_steam
if "%choice%"=="3" goto install_wemod
if "%choice%"=="4" goto exit

echo Invalid choice. Please enter a number from 1 to 4.
pause
goto menu

:install_drivers
echo Installing Steam Deck Drivers...
:: Add your driver installation commands here
pause
goto menu

:install_steam
echo Installing Steam...
:: Use PowerShell to check for admin privileges and run Steam\install.bat with elevation
powershell -command "& {Start-Process -filepath 'Steam\install.bat' -verb runas}"
pause
goto menu

:install_wemod
echo Installing WeMod...
call WeMod\install.bat
pause
goto menu

:exit
echo Exiting the menu.
pause
exit
