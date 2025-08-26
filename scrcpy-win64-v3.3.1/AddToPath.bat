@echo off
setlocal enabledelayedexpansion

:: Set the window title
TITLE Add Current Directory to SYSTEM PATH

:: Get the current directory
set "CURRENT_DIR=%~dp0"
:: Remove trailing backslash if it exists
if "!CURRENT_DIR:~-1!"=="\" set "CURRENT_DIR=!CURRENT_DIR:~0,-1!"

echo This script will add the following directory to your SYSTEM Path variable:
echo %CURRENT_DIR%
echo.

:: Use reg query to get the current SYSTEM PATH from the registry.
:: This is more reliable than using %PATH% which only reflects the current session.
FOR /F "tokens=2,*" %%A IN ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') DO set "SYSTEM_PATH=%%B"

:: If Path does not exist, reg query will fail. Initialize SYSTEM_PATH.
if not defined SYSTEM_PATH (
    set "SYSTEM_PATH="
)

:: Check if the directory is already in the system PATH
echo "!SYSTEM_PATH!" | find /I "%CURRENT_DIR%" > nul
if %errorlevel%==0 (
    echo The directory is already in your system PATH.
    echo No changes were made.
) else (
    echo This directory is not in your system PATH. Adding it now...

    :: Append the new directory. Use setx /M to make the change permanent for the system.
    setx /M Path "!SYSTEM_PATH!;%CURRENT_DIR%"

    if !errorlevel!==0 (
        echo.
        echo SUCCESS!
        echo The directory has been added to your system PATH.
        echo.
        echo IMPORTANT: Please RESTART any open Command Prompt or PowerShell windows for the change to take effect.
    ) else (
        echo.
        echo FAILED to add the directory to PATH.
        echo Please ensure you are running this script as an administrator.
    )
)

echo.
pause

