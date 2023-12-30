@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: Check if script is run as administrator
if %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    echo Set objShell = CreateObject("Shell.Application") > "%TEMP%\admincheck.vbs"
    echo Set objFolder = objShell.Namespace(32) >> "%TEMP%\admincheck.vbs"
    echo Set objFolderItem = objFolder.Self >> "%TEMP%\admincheck.vbs"
    echo If objFolderItem.IsLink Then >> "%TEMP%\admincheck.vbs"
    echo     WScript.Echo "Elevated" >> "%TEMP%\admincheck.vbs"
    echo Else >> "%TEMP%\admincheck.vbs"
    echo     WScript.Echo "Not Elevated" >> "%TEMP%\admincheck.vbs"
    echo End If >> "%TEMP%\admincheck.vbs"

    for /f %%i in ('cscript //nologo "%TEMP%\admincheck.vbs"') do set "adminStatus=%%i"

    if /i "%adminStatus%" neq "Elevated" (
        echo Please run this script as an administrator.
        exit /b 1
    )
)

set "steamInstallerUrl=https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
set "steamInstallerPath=%TEMP%\SteamSetup.exe"

echo Downloading Steam installer...
curl -o "%steamInstallerPath%" "%steamInstallerUrl%"

echo Installing Steam...
start /wait "" "%steamInstallerPath%"

echo Cleaning up...
del "%steamInstallerPath%"

echo Installation complete.
