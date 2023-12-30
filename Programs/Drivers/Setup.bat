@echo off
:menu
cls
echo Menu:
echo 1. APU (CPU + GPU)
echo 2. WI-FI
echo 3. BT
echo 4. SD
echo 5. AUDIO
echo 6. Exit

set /p choice=Enter your choice (1-6): 

if "%choice%"=="1" goto install_apu
if "%choice%"=="2" goto install_wifi
if "%choice%"=="3" goto install_bt
if "%choice%"=="4" goto install_sd
if "%choice%"=="5" goto install_audio
if "%choice%"=="6" goto exit

echo Invalid choice. Please enter a number from 1 to 4.
pause
goto menu

:install_apu
echo Installing Steam Deck Drivers...
:: Add your driver installation commands here
pause
goto menu

:install_wifi
echo Installing Steam...
:: Use PowerShell to check for admin privileges and run Steam\install.bat with elevation
powershell -command "& {Start-Process -filepath 'Steam\install.bat' -verb runas}"
pause
goto menu

:install_bt
echo Installing WeMod...
call WeMod\install.bat
pause
goto menu

:exit
echo Exiting the menu.
pause
exit
