@echo off

echo Installing Audio driver cs35l41
pnputil /add-driver "cs35l41-V1.2.1.0\cs35l41.inf" /install

if %errorlevel% equ 0 (
    echo cs35l41 driver installed successfully.
) else (
    echo Failed to install cs35l41 driver.
    goto :driver_error
)

:: Check for specific conditions for cs35l41
:: Add your conditions here based on the success or failure of the installation
:: If a condition is not met, go to :driver_error

echo Installing Audio driver NAU88L21
pnputil /add-driver "NAU88L21_x64_1.0.6.0_WHQL-DUA_BIQ_WHQL\NAU88L21.inf" /install

if %errorlevel% equ 0 (
    echo NAU88L21 driver installed successfully.
) else (
    echo Failed to install NAU88L21 driver.
    goto :driver_error
)

:: Check for specific conditions for NAU88L21
:: Add your conditions here based on the success or failure of the installation
:: If a condition is not met, go to :driver_error

pause
exit

:driver_error
echo ***********************************************
echo An error occurred during the audio driver installation.
echo ***********************************************
:: You can add additional error-handling steps here if needed
pause
exit
