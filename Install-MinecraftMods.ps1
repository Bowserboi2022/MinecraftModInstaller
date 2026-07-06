<#
.SYNOPSIS
    Backs up existing Minecraft mods and installs the mod jars sitting in the
    "mods" subfolder next to this script.

.DESCRIPTION
    1. Moves every .jar currently in your Minecraft mods folder into a
       timestamped backup folder in your Downloads folder (nothing is
       ever deleted).
    2. Copies every .jar found in the local ".\mods" subfolder into your
       Minecraft mods folder.

    TO ADD A NEW MOD LATER:
      Just drop the new .jar file into the "mods" subfolder next to this
      script, then run the script again. No editing required.

.NOTES
    Keep this script and the "mods" folder together, e.g.:

        MinecraftModInstaller\
            Install-MinecraftMods.ps1
            mods\
                balm-fabric-...jar
                fabric-api-...jar
                ... (etc)

    Run it by right-clicking > "Run with PowerShell", or from a PowerShell
    window:  .\Install-MinecraftMods.ps1
#>

param(
    # Folder holding the mod jars to install (defaults to .\mods next to this script)
    [string]$ModsSourceFolder = (Join-Path $PSScriptRoot "mods"),

    # Your Minecraft mods folder (default = vanilla launcher location)
    [string]$MinecraftMods = "$env:APPDATA\.minecraft\mods",

    # Where to put the backup of your existing mods (default = your actual
    # Downloads folder, wherever Windows has it - even if it's been moved
    # to another drive)
    [string]$BackupParent
)

if (-not $BackupParent) {
    try {
        $BackupParent = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders").'{374DE290-123F-4565-9164-39C4925E467B}'
        $BackupParent = [Environment]::ExpandEnvironmentVariables($BackupParent)
    } catch {
        $BackupParent = "$env:USERPROFILE\Downloads"
    }
}

$ErrorActionPreference = "Stop"

Write-Host "=== Minecraft Mod Installer ===" -ForegroundColor Cyan
Write-Host "Mods folder:   $MinecraftMods"
Write-Host "Source folder: $ModsSourceFolder"
Write-Host "Backups go to: $BackupParent"
Write-Host ""

if (-not (Test-Path $ModsSourceFolder)) {
    Write-Host "ERROR: source folder '$ModsSourceFolder' does not exist." -ForegroundColor Red
    exit 1
}

# 1. Make sure the destination mods folder exists
if (-not (Test-Path $MinecraftMods)) {
    Write-Host "Mods folder not found, creating it..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $MinecraftMods -Force | Out-Null
}

# 2. Back up whatever jars are already installed
$existingJars = Get-ChildItem -Path $MinecraftMods -Filter *.jar -File -ErrorAction SilentlyContinue

if ($existingJars.Count -gt 0) {
    $timestamp    = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $backupFolder = Join-Path $BackupParent "mods_backup_$timestamp"
    New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null

    Write-Host "Backing up $($existingJars.Count) existing mod(s) to:" -ForegroundColor Yellow
    Write-Host "  $backupFolder"

    foreach ($jar in $existingJars) {
        Move-Item -Path $jar.FullName -Destination $backupFolder -Force
        Write-Host "  moved: $($jar.Name)"
    }
} else {
    Write-Host "No existing mods found - nothing to back up." -ForegroundColor Gray
}

Write-Host ""

# 3. Copy in every jar from the bundled mods folder
$newJars = Get-ChildItem -Path $ModsSourceFolder -Filter *.jar -File -ErrorAction SilentlyContinue

if (-not $newJars -or $newJars.Count -eq 0) {
    Write-Host "No .jar files found in '$ModsSourceFolder' - nothing to install." -ForegroundColor Red
    exit 1
}

foreach ($jar in $newJars) {
    Copy-Item -Path $jar.FullName -Destination $MinecraftMods -Force
    Write-Host "  installed: $($jar.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. $($newJars.Count) mod(s) installed into $MinecraftMods" -ForegroundColor Cyan
