# Minecraft Mod Installer

A simple drag-and-drop mod pack installer for Fabric 26.1.2. Backs up your existing mods automatically, then installs the new set — safe to re-run any time.

## What this does

- **Backs up** whatever mods you currently have installed, moving them to a `mods_backup_<date>` folder in your Downloads folder (nothing is deleted).
- **Installs** every `.jar` file found in the `mods` folder here into your Minecraft mods folder.

## How to use it

1. Download the latest package named `MinecraftModInstaller.zip` and unzip it somewhere (Desktop, Downloads, wherever).
2. Double-click `Run-Installer.bat`.
3. A window will open, show progress, and pause at the end so you can read it. Press any key to close it when you're done.

That's it. By default it installs into:

```
%APPDATA%\.minecraft\mods
```

(the standard/vanilla Minecraft launcher's mods folder)

## Using a different launcher (MultiMC, Prism, CurseForge, etc.)

If your instance's mods folder is somewhere else, don't use `Run-Installer.bat` — instead open PowerShell in this folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-MinecraftMods.ps1 -MinecraftMods "C:\path\to\your\instance\mods"
```

## How to install Fabric

Fabric is required before any of these mods will run — this is a crucial first step.

1. Download and install Fabric for Minecraft **26.1.2** (the installer program is linked in this repo).
2. Run the installer.
3. Set the **Minecraft Version** to `26.1.2`.
4. Use the **latest Loader Version**.
5. Leave the install location as default.
6. Check **Create Profile** and click **Install**.

When you're finished, the Minecraft Launcher should have a new **"Fabric 26.1.2"** profile.

## Adding / updating mods later

Just drop new or updated `.jar` files into the `mods` folder here, then run `Run-Installer.bat` again. Old mods currently installed get backed up automatically each time, so it's always safe to re-run.

## Troubleshooting

- **"Cannot be loaded" / "not digitally signed"** — this is exactly what `Run-Installer.bat` works around, so make sure you're using that instead of double-clicking the `.ps1` directly.
- **Nothing seems to happen** — make sure you extracted the `.zip` first (don't run it from inside the zip file / File Explorer preview).
