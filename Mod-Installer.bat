@echo off

set ver=Version 5.1.2.2

    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:start
cd "%ProgramFiles%\Mod-Installer"
curl -sL -o %0 https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/Mod-Installer.bat
curl -sL -o MC-Launcher.bat https://raw.githubusercontent.com/SanCraftDev/Mod-Installer/main/MC-Launcher.bat
if not exist "%ProgramFiles%\Mod-Installer" (
CLS
echo.
echo You need to reinstall the Mod-Installer!
echo.
Pause
start "" "%appdata%\Microsoft\Windows\Start Menu\Programs\Mod-Installer\Installer-Uninstaller.lnk"
GOTO end
)

FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )
if exist "%appdata%\.minecraft\fabric.jar" (
del /S /Q "%appdata%\.minecraft\fabric.jar"
)
if exist "%appdata%\.minecraft\1.17.bat" (
del /S /Q "%appdata%\.minecraft\1.17.bat"
)
if exist "%appdata%\.minecraft\Update.bat" (
del /S /Q "%appdata%\.minecraft\Update.bat"
)
if exist "%appdata%\.minecraft\essential-installer.exe" (
del /S /Q "%appdata%\.minecraft\essential-installer.exe"
)

set l=1.17.1
set lfl=0.12.8
set fal=fabric-loader-%lfl%-%l%
CLS
C:
    where java >nul 2>nul
    if %errorlevel%==1 (    
	echo.
	echo  java is not installed, it will now be installed!
	echo  Start now?
	Pause
	winget install -e --id Amazon.Corretto.17
	GOTO restart
)
if not exist "%appdata%\.minecraft" (
    CLS
    echo  .minecraft folder not at the usual path or not available.
	echo  Under "%appdata%\.minecraft"
	echo  Unable to start Minecraft!
	echo  Do you want to open the Minecraft Launcher and test it again afterwards?
	Pause
	start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
	echo  Started?
	Pause
    TASKKILL /T /F /IM MinecraftLauncher.exe
    TASKKILL /T /F /IM Minecraft.exe
	GOTO restart
)

C:
cd %appdata%\.minecraft
if exist *.tar (
echo  Your Profiles and the Backup need to be converted from a .tar file to a .zip file
echo  Start now?
Pause
echo  converting Profiles and Backups from .tar to .zip...
if exist Backup.tar (
rmdir /S /Q mods
tar xf Backup.tar
tar acf Backup.zip mods options.txt
echo  Backup converted to a zip file!
)
if exist Profil-1.tar (
rmdir /S /Q mods
tar xf Profil-1.tar
tar acf Profil-1.zip mods options.txt
echo  Profil-1 converted to a zip file!
)
if exist Profil-2.tar (
rmdir /S /Q mods
tar xf Profil-2.tar
tar acf Profil-2.zip mods options.txt
echo  Profil-2 converted to a zip file!
)
if exist Profil-3.tar (
rmdir /S /Q mods
tar xf Profil-3.tar
tar acf Profil-3.zip mods options.txt
echo  Profil-3 converted to a zip file!
)
if exist Profil-4.tar (
rmdir /S /Q mods
tar xf Profil-4.tar
tar acf Profil-4.zip mods options.txt
echo  Profil-4 converted to a zip file!
)
if exist Profil-5.tar (
rmdir /S /Q mods
tar xf Profil-5.tar
tar acf Profil-5.zip mods options.txt
echo  Profil-5 converted to a zip file!
)
if exist Profil-6.tar (
rmdir /S /Q mods
tar xf Profil-6.tar
tar acf Profil-6.zip mods options.txt
echo  Profil-6 converted to a zip file!
)
if exist Profil-7.tar (
rmdir /S /Q mods
tar xf Profil-7.tar
tar acf Profil-7.zip mods options.txt
echo  Profil-7 converted to a zip file!
)
if exist Profil-8.tar (
rmdir /S /Q mods
tar xf Profil-8.tar
tar acf Profil-8.zip mods options.txt
echo  Profil-8 converted to a zip file!
)
del /S /Q *.tar
echo  Finished! Now starting the Mod-Installer...
Pause
)

move servers.dat_tmp servers.dat
CLS
	echo.
	echo  Client-Mods/Modpack Versions:
	echo.
	echo  a) Iris + Sodium (1.16.5+)  - https://irisshaders.net
	echo  b) Optifine      (1.7.2+)   - https://optifine.net/downloads - NO direct Download!
	echo  c) Fabric-Loader (1.14+)    - https://fabricmc.net/use
	echo  d) Forge-Loader  (1.6.4+)   - https://files.minecraftforge.net/net/minecraftforge/forge
	echo  e) Essential     (1.8.9+)   - https://essential.gg
	echo.
	echo  f) 1.18 - Beta              - Fabric-Loader Modpacks
	echo  g) 1.17                     - Fabric-Loader Modpacks
	echo  h) 1.8                      - Forge-Loader  Modpacks - PVP
	echo  i) Rescource Packs          - Download Resourcepacks!
	echo.
	echo  j) Backups/Modprofile       - Create Mod-/Config-Profils
	echo  k) Profil Update            - Load a profile to update it and then automatically save it again!
	echo.
	echo  Funktions:
	echo.
	echo  l) .minecraft Cleaner       - Clear your .minecraft folder up!
    echo  m) Restart Installer
	echo  n) End Installer
	echo  o) Give feedback            - %ver%
	echo.
    CHOICE /C abcdefghijklmnop /M " Selection: "
    IF ERRORLEVEL 15 GOTO fb
    IF ERRORLEVEL 14 GOTO end
    IF ERRORLEVEL 13 GOTO restart
	IF ERRORLEVEL 12 GOTO c
    IF ERRORLEVEL 11 GOTO update
	IF ERRORLEVEL 10 GOTO bp
	IF ERRORLEVEL 9 GOTO rp
	IF ERRORLEVEL 8 GOTO 1.8
    IF ERRORLEVEL 7 GOTO 1.17
    IF ERRORLEVEL 6 GOTO 1.18
    IF ERRORLEVEL 5 GOTO ess
	IF ERRORLEVEL 4 GOTO forge
	IF ERRORLEVEL 3 GOTO fabric
	IF ERRORLEVEL 2 GOTO of
	IF ERRORLEVEL 1 GOTO iris

:1.17
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Minigames = Only Grafikmods, Lite = light Mods, Full = Minimap, WTHIT...
echo  Only the Minigame Pack should be allowed on Servers like Hypixel
echo.
echo  1. 1.17 Client Mods Survival
echo  2. 1.17 Client Mods Minigames
echo.
echo  3. Wurst Hack-Client - If you use this, I can say you, you get guaranteed banned
echo  4. Replaymod
echo.
echo  5. Restart Installer
echo  6. End Installer
echo.
CHOICE /C 123456 /M "RECOMMENDATION! SAFE MODS IN A PROFILE! THEY WILL BE REMOVED! Selection: "
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO restart
IF ERRORLEVEL 4 GOTO rpm
IF ERRORLEVEL 3 GOTO whc
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.17-Minigames.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.17.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
rmdir /S /Q mods
tar xf mods.zip
del /S /Q mods.zip
curl -sL -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar client -mcversion %l% -launcher microsoft_store -loader %lfl%
del /S /Q fabric.jar
GOTO mif

:1.18
C:
cd %appdata%\.minecraft
CLS
echo.
echo  Minigames = Only Grafikmods, Lite = light Mods, Full = Minimap, WTHIT...
echo  Only the Minigame Pack should be allowed on Servers like Hypixel
echo.
echo  1. 1.18 Client Mods Survival
echo  2. 1.18 Client Mods Minigames
echo.
echo  3. Wurst Hack-Client - If you use this, I can say you, you get guaranteed banned
echo.
echo  4. Restart Installer
echo  5. End Installer
echo.
CHOICE /C 123456 /M "RECOMMENDATION! SAFE MODS IN A PROFILE! THEY WILL BE REMOVED! Selection: "
IF ERRORLEVEL 5 GOTO end
IF ERRORLEVEL 4 GOTO restart
IF ERRORLEVEL 3 GOTO whc8
IF ERRORLEVEL 2 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.18-Minigames.zip
IF ERRORLEVEL 1 curl -L -o mods.zip https://dl.sancraft.dev/mp/1.18.zip
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
rmdir /S /Q mods
tar xf mods.zip
del /S /Q mods.zip
curl -sL -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar client -mcversion 1.18 -launcher microsoft_store -loader %lfl%
del /S /Q fabric.jar
GOTO mif

:whc
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
cd %appdata%\.minecraft\mods
CLS
curl -L -o wurst.jar https://github.com/Wurst-Imperium/Wurst-MCX2/releases/download/v7.18/Wurst-Client-v7.18-MC%l%.jar
GOTO mif

:rpm
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
cd %appdata%\.minecraft\mods
CLS
curl -L -o replaymod.jar https://minio.replaymod.com/replaymod/replaymod-%l%-2.6.1.jar
GOTO mif

:whc8
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
cd %appdata%\.minecraft\mods
CLS
curl -L -o wurst.jar https://github.com/Wurst-Imperium/Wurst-MCX2/releases/download/v7.18/Wurst-Client-v7.18-MC1.18.jar
GOTO mif

:1.8
C:
cd %appdata%\.minecraft
CLS
echo  Installation starting...
curl -L -o mods.zip https://dl.sancraft.dev/mp/1.8.zip
tar acf Backup.zip mods options.txt
CLS
curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
echo  In the next step a window will open automatically, just click on "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
rmdir /S /Q mods
tar xf mods.zip
del /S /Q mods.zip
GOTO mif

:fabric
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
curl -sL -o fabric.jar https://dl.sancraft.dev/fa
java -jar fabric.jar
del /S /Q fabric.jar
GOTO mif

:iris
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
curl -sL -o iris.jar https://dl.sancraft.dev/iris
java -jar iris.jar
del /S /Q iris.jar
GOTO mif

:of
start "" https://optifine.net/downloads
GOTO mif

:forge
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
echo.
echo  Which Forge version do you want to install?
echo.
echo  a) latest version
echo  b) 1.6.4
echo  c) 1.17.10
echo  d) 1.8.9
echo  e) 1.9.4
echo  f) 1.10.2
echo  g) 1.11.2
echo  h) 1.12.2
echo  i) 1.13.2
echo  j) 1.14.3
echo  k) 1.14.4
echo  l) 1.15
echo  m) 1.15.1
echo  n) 1.15.2
echo  o) 1.16.1
echo  p) 1.16.2
echo  q) 1.16.3
echo  r) 1.16.4
echo  s) 1.16.5
echo  t) 1.17.1
echo  u) 1.18
echo.
CHOICE /C abcdefghijklmnopqrstu /M " Selection: "
IF ERRORLEVEL 21 curl -sL -o forge.jar https://dl.sancraft.dev/fo/1.18
IF ERRORLEVEL 20 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.17.1-37.1.0/forge-1.17.1-37.1.0-installer.jar
IF ERRORLEVEL 19 curl -sL -o forge.jar https://dl.sancraft.dev/fo/1.16.5
IF ERRORLEVEL 18 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.4-35.1.37/forge-1.16.4-35.1.37-installer.jar
IF ERRORLEVEL 17 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.3-34.1.42/forge-1.16.3-34.1.42-installer.jar
IF ERRORLEVEL 16 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.2-33.0.61/forge-1.16.2-33.0.61-installer.jar
IF ERRORLEVEL 15 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.1-32.0.108/forge-1.16.1-32.0.108-installer.jar
IF ERRORLEVEL 14 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.2-31.2.55/forge-1.15.2-31.2.55-installer.jar
IF ERRORLEVEL 13 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15.1-30.0.51/forge-1.15.1-30.0.51-installer.jar
IF ERRORLEVEL 12 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.15-29.0.4/forge-1.15-29.0.4-installer.jar
IF ERRORLEVEL 11 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.4-28.2.23/forge-1.14.4-28.2.23-installer.jar
IF ERRORLEVEL 10 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.14.3-27.0.60/forge-1.14.3-27.0.60-installer.jar
IF ERRORLEVEL 9 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.13.2-25.0.219/forge-1.13.2-25.0.219-installer.jar
IF ERRORLEVEL 8 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar
IF ERRORLEVEL 7 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.11.2-13.20.1.2588/forge-1.11.2-13.20.1.2588-installer.jar
IF ERRORLEVEL 6 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.10.2-12.18.3.2511/forge-1.10.2-12.18.3.2511-installer.jar
IF ERRORLEVEL 5 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.9.4-12.17.0.2317-1.9.4/forge-1.9.4-12.17.0.2317-1.9.4-installer.jar
IF ERRORLEVEL 4 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.8.9-11.15.1.2318-1.8.9/forge-1.8.9-11.15.1.2318-1.8.9-installer.jar
IF ERRORLEVEL 3 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.7.10-10.13.4.1614-1.7.10/forge-1.7.10-10.13.4.1614-1.7.10-installer.jar
IF ERRORLEVEL 2 curl -sL -o forge.jar https://maven.minecraftforge.net/net/minecraftforge/forge/1.6.4-9.11.1.1345/forge-1.6.4-9.11.1.1345-installer.jar
IF ERRORLEVEL 1 curl -sL -o forge.jar https://dl.sancraft.dev/fo/latest
echo  In the next step a window will open automatically, just click on "OK"!
Pause
java -jar forge.jar
del /S /Q forge.jar
del /S /Q forge.jar.log
GOTO mif

:ess
echo  Installation starting...
C:
cd %appdata%\.minecraft
tar acf Backup.zip mods options.txt
CLS
curl -sL -o essential-installer.exe https://cdn.essential.gg/launcher_versions/1.0.6/windows/essential-installer-0.0.1.exe
start essential-installer.exe
Pause
del /S /Q essential-installer.exe
GOTO mif

:mif
CLS
echo.
echo  Finisched!
echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Create Profile
echo  4. Start Minecraft
CHOICE /C 1234 /M " Selection: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart


:rp
C:
cd %appdata%\.minecraft\resourcepacks
CLS
echo.
echo  Rescource Packs:
echo.
echo  a) Remove pumpkin sight                               - Pumpkin.zip
echo  b) Dark Mode - make Minecraft darker!                 - https://sancraft.dev/dark
echo  c) Xray - often not welcome                           - https://sancraft.dev/xray
echo  d) Textures of the newer Versions for 1.8             - https://sancraft.dev/18new and https://sancraft.dev/18new2 - combined
echo  e) 1.8 PVP Pack (from BastiGHG) - NO direct Download! - https://resourcepacks24.de/resourcepack/53862
echo  f) BD-Craft - NO direct Download!                     - https://bdcraft.net/downloads/
echo.
echo  g) Restart Mod-Installer
echo  h) Mod-End Installer
echo.
CHOICE /C abcdefgh /M " Selection: "
IF ERRORLEVEL 8 GOTO end
IF ERRORLEVEL 7 GOTO restart
IF ERRORLEVEL 6 GOTO bdc
IF ERRORLEVEL 5 GOTO pvp
IF ERRORLEVEL 4 GOTO 1.8-new
IF ERRORLEVEL 3 GOTO xray
IF ERRORLEVEL 2 GOTO dm
IF ERRORLEVEL 1 GOTO ps

:ps
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -sL -o pumpkin-1.8.zip  https://dl.sancraft.dev/mp/pumpkin-1.8.zip
IF ERRORLEVEL 2 curl -sL -o pumpkin-1.16.zip  https://dl.sancraft.dev/mp/pumpkin-1.16.zip
IF ERRORLEVEL 1 curl -sL -o pumpkin-1.17.zip  https://dl.sancraft.dev/mp/pumpkin-1.17.zip
GOTO rpif

:dm
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
echo  3. 1.8
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 curl -sL -o Dark-Mode-1.8.zip https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.8-v1.3.1.zip
IF ERRORLEVEL 2 curl -sL -o Dark-Mode-1.16.zip https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.16.2+-v1.3.1.zip
IF ERRORLEVEL 1 curl -sL -o Dark-Mode-1.17.zip https://github.com/xnebulr/Minecraft-Default-Dark-Mode/releases/latest/download/Default-Dark-Mode-1.17-v1.3.1.zip
GOTO rpif

:xray
echo  Download starting...
echo  1. 1.17
echo  2. 1.16
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 curl -sL -o Xray-1.16.zip  https://media.forgecdn.net/files/3226/914/Xray_Ultimate_1.16_v4.1.0.zip
IF ERRORLEVEL 1 curl -sL -o Xray-1.17.zip  https://media.forgecdn.net/files/3359/914/Xray_Ultimate_1.17_v4.1.2.zip
GOTO rpif

:1.8-new
curl -sL -o 1.8-rp.zip  https://dl.sancraft.dev/mp/1.8-rp.zip
GOTO rpif

:pvp
start "" https://resourcepacks24.de/download/53862
echo  Download starting...
GOTO rpif

:bdc
start "" https://bdcraft.net/downloads/
GOTO rpif

:rpif
echo.
echo  Finished!
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Download more Resourcepacks
CHOICE /C 123 /M " Selection: "
IF ERRORLEVEL 3 GOTO rp
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:bp
C:
cd "%appdata%\.minecraft\"
CLS
echo  Make sure that you select the correct modloader and MC version in the Minecraft Launcher in the lower left!
echo  Only mods in the profiles are saved and loaded!
echo  In the backup also configs!
echo.
echo  1. Create profile - Limit 8 - Existing ones will be overwritten
echo  2. Load Profile
echo  3. Delete Profile
echo  4. Load backup - Automatically created during mod installation and MC start - Mods will be overwritten
echo.
echo  5. Restart Installer
echo  6. End Installer
echo.
echo  CAUTION! PROFILES ARE NOT RECOVERABLE!
CHOICE /C 123456 /M " Selection: "
IF ERRORLEVEL 6 GOTO end
IF ERRORLEVEL 5 GOTO restart
IF ERRORLEVEL 4 GOTO bl
IF ERRORLEVEL 3 GOTO pr
IF ERRORLEVEL 2 GOTO pl
IF ERRORLEVEL 1 GOTO pc

:bl
rmdir /S /Q mods
tar xf Backup.zip
GOTO pbf

:pr
CLs
echo.
echo  Which profile do you want to delete?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 del /S /Q Profil-8.zip
IF ERRORLEVEL 7 del /S /Q Profil-7.zip
IF ERRORLEVEL 6 del /S /Q Profil-6.zip
IF ERRORLEVEL 5 del /S /Q Profil-5.zip
IF ERRORLEVEL 4 del /S /Q Profil-4.zip
IF ERRORLEVEL 3 del /S /Q Profil-3.zip
IF ERRORLEVEL 2 del /S /Q Profil-2.zip
IF ERRORLEVEL 1 del /S /Q Profil-1.zip
GOTO pbf

:pl
CLS
echo.
echo  Which profile do you want to load?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar xf Profil-8.zip
IF ERRORLEVEL 7 tar xf Profil-7.zip
IF ERRORLEVEL 6 tar xf Profil-6.zip
IF ERRORLEVEL 5 tar xf Profil-5.zip
IF ERRORLEVEL 4 tar xf Profil-4.zip
IF ERRORLEVEL 3 tar xf Profil-3.zip
IF ERRORLEVEL 2 tar xf Profil-2.zip
IF ERRORLEVEL 1 tar xf Profil-1.zip
echo  Loaded!

echo  1. Restart Mod-Installer
echo  2. End Installer
echo  3. Create Profile
echo  4. Start Minecraft
CHOICE /C 1234 /M " Selection: "
IF ERRORLEVEL 4 GOTO mcl
IF ERRORLEVEL 3 GOTO pc
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:mcl
echo  Starting...
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
C:
cd %ProgramFiles%\Mod-Installer\
start "" shell:AppsFolder\Microsoft.4297127D64EC6_8wekyb3d8bbwe!Minecraft 
EXIT /B

:pc
CLs
echo.
echo  Under which profile do you want to save the current mods and configs?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar acf Profil-8.zip mods options.txt
IF ERRORLEVEL 7 tar acf Profil-7.zip mods options.txt
IF ERRORLEVEL 6 tar acf Profil-6.zip mods options.txt
IF ERRORLEVEL 5 tar acf Profil-5.zip mods options.txt
IF ERRORLEVEL 4 tar acf Profil-4.zip mods options.txt
IF ERRORLEVEL 3 tar acf Profil-3.zip mods options.txt
IF ERRORLEVEL 2 tar acf Profil-2.zip mods options.txt
IF ERRORLEVEL 1 tar acf Profil-1.zip mods options.txt
CLS
echo.
echo  Finished! 
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart


:update
cd "%appdata%\.minecraft\"
CLS
echo.
echo  Which profile do you want to update (the profile is loaded so that all configs are adopted)?
echo.
CHOICE /C 12345678 /M " Selection: "
IF ERRORLEVEL 8 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-8.zip & set P=8
IF ERRORLEVEL 7 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-7.zip & set P=7
IF ERRORLEVEL 6 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-6.zip & set P=6
IF ERRORLEVEL 5 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-5.zip & set P=5
IF ERRORLEVEL 4 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-4.zip & set P=4
IF ERRORLEVEL 3 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-3.zip & set P=3
IF ERRORLEVEL 2 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-2.zip & set P=2
IF ERRORLEVEL 1 tar acf Backup.zip mods options.txt & rmdir /S /Q mods & tar xf Profil-1.zip & set P=1
cd "%appdata%\.minecraft\mods\"
if exist Update.bat (
  move Update.bat "%appdata%\.minecraft\"
  cd "%appdata%\.minecraft\"
  CLS
  Update.bat
  CLS
  tar acf Profil-%P%.zip mods options.txt
  del /S /Q "%appdata%\.minecraft\fabric.jar"
  del /S /Q "%appdata%\.minecraft\1.17.bat"
  del /S /Q "%appdata%\.minecraft\Fabric-Install.bat"
  del /S /Q "%appdata%\.minecraft\Update.bat"
  CLS
  echo.
  echo  Update finished! - Profil %P%
  echo  Restart Installer...
  start %ComSpec% /C %0
  Pause
  Exit /B
) else (
  CLS
  echo.
  echo  Unfortunately, this profile does not support the update function!
  echo  Please update it manually!
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart
)

:c
CLS
echo.
echo  Do you really want to remove not needed Files and Folders of your .minecraft Folder?
echo  Your Minecraft Launcher will be closed!
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO cy
IF ERRORLEVEL 1 GOTO end

:cy
cd "%appdata%\.minecraft"
tar acf Backup.zip mods options.txt
TASKKILL /T /F /IM MinecraftLauncher.exe
TASKKILL /T /F /IM Minecraft.exe
rmdir /S /Q "%appdata%\.iris-installer"
rmdir /S /Q .icons
rmdir /S /Q .mixin.out
rmdir /S /Q .replay_cache
rmdir /S /Q .fabric
rmdir /S /Q ViaForge
rmdir /S /Q assets
rmdir /S /Q bettergamemenu
rmdir /S /Q craftpresence
rmdir /S /Q crash-reports
rmdir /S /Q defaultconfigs
rmdir /S /Q logs
rmdir /S /Q ModTranslations
rmdir /S /Q not-enough-crashes
rmdir /S /Q server-resource-packs
rmdir /S /Q bin
rmdir /S /Q cachedImages
rmdir /S /Q libraries
rmdir /S /Q webcache2
rmdir /S /Q debug
rmdir /S /Q libraries 
rmdir /S /Q stats
rmdir /S /Q texturepacks-mp-cache
rmdir /S /Q webcache
del /S /Q versions\version_manifest_v2*
del /S /Q versions\cache.dat
del /S /Q betterfps.txt
del /S /Q clientId.txt
del /S /Q deaths.dat
del /S /Q servers.dat_old
del /S /Q textures_*.png
del /S /Q updateLog.txt
del /S /Q usercache*
del /S /Q usernamecache*
del /S /Q launcher_log.txt
del /S /Q level.dat
del /S /Q realms_persistence*
del /S /Q launcher_cef_log.txt
del /S /Q output-server.log
del /S /Q output-client.log
del /S /Q debug.stitched_items.png
del /S /Q debug.stitched_terrain.png
del /S /Q hotbar.nbt
del /S /Q lastlogin
del /S /Q resourcepacks*
del /S /Q treatment_tags*
del /S /Q hs_err_pid*
del /S /Q options.amecsapi.txt
del /S /Q launcher_ui_state*
del /S /Q launcher_settings*
del /S /Q launcher_gamer_pics*
del /S /Q launcher_entitlements*
del /S /Q .iasx
del /S /Q .iasp
del /S /Q .iasms_v2
del /S /Q launcher_accounts.*
del /S /Q launcher_msa_credentials.*
del /S /Q launcher_profiles.*
del /S /Q launcher_ui_state.*

if exist "%appdata%\.minecraft\wurst" (
echo.
echo Hello Hacker/Cheater do you want to delete your Wurst Configs?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\wurst"
IF ERRORLEVEL 1 echo OK, Happy Hacking/Cheating!
)
if exist "%appdata%\.minecraft\XaeroWaypoints" (
echo.
echo  Do you want to delete your Xaero Waypoints?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\XaeroWaypoints"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\bettercommandblock_script" (
echo.
echo  Do you want to delete your bettercommandblock scripts?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\bettercommandblock_script"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\replay_recordings" (
echo.
echo  Do you want to delete your replay recordings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\replay_recordings"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\backups" (
echo.
echo  Do you want to delete your world backups?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\backups"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\saves" (
echo.
echo  Do you want to delete ALL your worlds?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\saves"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\shaderpacks" (
echo.
echo  Do you want to delete ALL your shaderpacks?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\shaderpacks"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\resourcepacks" (
echo.
echo  Do you want to delete ALL your resourcepacks?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\resourcepacks"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\config" (
echo.
echo  Do you want to delete ALL your current loaded mod configs?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\config"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\mods" (
echo.
echo  Do you want to delete ALL your current loaded mods?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\mods"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\servers.dat" (
echo.
echo  Do you want to delete your server list?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\servers.*"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\options.txt" (
echo.
echo  Do you want to delete ALL your current loaded OPTIONS?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\options*"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\screenshots" (
echo.
echo  Do you want to delete ALL your minecraft screenshots?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\screenshots"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\hotbar.nbt" (
echo.
echo  Do you want to delete your saved hotbars?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\hotbar.nbt"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\essential" (
echo.
echo  Do you want to delete your essential settings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\essential"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\cosmetics" (
echo.
echo  Do you want to delete your cosmetics?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\cosmetics"
IF ERRORLEVEL 1 echo OK!
)
if exist "%appdata%\.minecraft\the5zigmod" (
echo.
echo  Do you want to delete your 5zig settings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 rmdir /S /Q "%appdata%\.minecraft\the5zigmod"
IF ERRORLEVEL 1 echo OK!
)

echo.
echo  Do you want to delete your launcher settings?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_settings*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete your skins?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_skins*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to LOGOUT from EVERY account in your minecraft launcher?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_accounts*" & del /S /Q "%appdata%\.minecraft\launcher_msa_credentials*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete all your launcher profiles, only vanila %l% will be kept?
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 del /S /Q "%appdata%\.minecraft\launcher_profiles*"
IF ERRORLEVEL 1 echo OK!

echo.
echo  Do you want to delete old Minecraft Versions and Snapshots? - only 1.8.9-vanila/forge and latest %l%-vanila/fabric will be kept
echo.
echo  1. No
echo  2. Yes
echo.
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO c1
IF ERRORLEVEL 1 GOTO c2

:c1
mkdir tmp
move versions\1.8.9 tmp
move versions\1.8.9-forge1.8.9-11.15.1.2318-1.8.9 tmp
move versions\%l% tmp
move versions\%fal% tmp
rmdir /S /Q versions
mkdir versions
move tmp\1.8.9 versions
move tmp\1.8.9-forge1.8.9-11.15.1.2318-1.8.9 versions
move tmp\%l% versions
move tmp\%fal% versions
rmdir /S /Q tmp

:c2
CLS
echo.
echo  Cleaned
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:fb
CLS
echo.
echo  https://sancraft.dev/discord
echo  https://github.com/SanCraftDev/Mod-Installer/issues/
echo.
echo  1. Restart Mod-Installer
echo  2. End Installer
CHOICE /C 12 /M " Selection: "
IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO restart

:restart
start %ComSpec% /C %0
EXIT /B

:end
EXIT /B
