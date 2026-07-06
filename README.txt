MINECRAFT MOD INSTALLER
=======================

WHAT THIS DOES
--------------
- Backs up whatever mods you currently have installed (moves them to a
  "mods_backup_<date>" folder in your Downloads folder - nothing is
  deleted).
- Installs every .jar file found in the "mods" folder here into your
  Minecraft mods folder.

HOW TO USE IT
-------------
1. Download the latest package named "MinecraftModInstaller.zip". Unzip this folder somewhere (Desktop, Downloads, wherever).
2. Double-click "Run-Installer.bat".
3. A window will open, show progress, and pause at the end so you can
   read it. Press any key to close it when you're done.

That's it. By default it installs into:
    %APPDATA%\.minecraft\mods
(the standard/vanilla Minecraft launcher's mods folder)

USING A DIFFERENT LAUNCHER (MultiMC, Prism, CurseForge, etc.)
---------------------------------------------------------------
If your instance's mods folder is somewhere else, don't use
Run-Installer.bat - instead open PowerShell in this folder and run:

    powershell -ExecutionPolicy Bypass -File .\Install-MinecraftMods.ps1 -MinecraftMods "C:\path\to\your\instance\mods"

----------------------------------------------------------------
HOW TO INSTALL FABRIC
Download and install Fabric for Minecraft 26.1.2. (the installer program is now linked in the repo)
Download the Fabric Installer.
Run the installer.
Set the Minecraft Version to 26.1.2.
Use the latest Loader Version.
Leave the install location as default.
Check "Create Profile" and click Install.

When you're finished, the Minecraft Launcher should have a new "Fabric 26.1.2" profile.
This is a crucial step to running the mods.

ADDING / UPDATING MODS LATER
-----------------------------
Just drop new/updated .jar files into the "mods" folder in here, then
run Run-Installer.bat again. Old mods currently installed get backed up
automatically each time, so it's always safe to re-run.

TROUBLESHOOTING
----------------
- If Windows says the script "cannot be loaded" or is "not digitally
  signed" - that's exactly what Run-Installer.bat works around, so make
  sure you're using that instead of double-clicking the .ps1 directly.
- If nothing seems to happen, make sure you extracted the .zip first
  (don't run it from inside the zip file/File Explorer preview).
