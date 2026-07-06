@echo off
REM Double-click this file to install/update the mods.
REM It launches the PowerShell script with the execution-policy restriction
REM bypassed for just this one run - nothing is changed system-wide.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-MinecraftMods.ps1"

echo.
pause
