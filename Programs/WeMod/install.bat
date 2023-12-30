@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: Check if script is run as administrator
if %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto :continue
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TEMP%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%TEMP%\getadmin.vbs"
    "%TEMP%\getadmin.vbs"
    del "%TEMP%\getadmin.vbs"
    exit /B

:continue
set "wemodInstallerUrl=https://www.wemod.com/api/download"

echo Downloading WeMod installer...
powershell -command "& { Invoke-WebRequest -Uri '%wemodInstallerUrl%' -OutFile '%TEMP%\WeModInstaller.exe' }"

echo Installing WeMod...
start /wait "" "%TEMP%\WeModInstaller.exe"

echo Cleaning up...
del "%TEMP%\WeModInstaller.exe"

echo Installation complete.
