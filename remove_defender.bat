@echo off
title Remove Windows Defender - Compatible with Win7/10/11
color 0A

echo [*] Checking for Administrator privileges...
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [!] Please run this script as Administrator.
    pause
    exit /b
)

echo [*] Stopping and removing Defender services...

:: Windows Defender (Win7/10/11)
sc stop WinDefend >nul 2>&1
sc delete WinDefend >nul 2>&1

:: Sense service (Win10/11 only)
sc stop Sense >nul 2>&1
sc delete Sense >nul 2>&1

:: SecurityHealthService (Win10/11)
sc stop SecurityHealthService >nul 2>&1
sc delete SecurityHealthService >nul 2>&1

echo [*] Removing Defender drivers (Win10/11)...
sc delete WdFilter >nul 2>&1
sc delete WdBoot >nul 2>&1
sc delete WdNisDrv >nul 2>&1
sc delete WdNisSvc >nul 2>&1

echo [*] Applying Registry changes to disable Defender and Telemetry...

:: Disable Defender and Real-Time Protection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul

:: Disable SpyNet/Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /t REG_DWORD /d 0 /f >nul

echo [*] Disabling Windows Defender Scheduled Tasks...

:: Loop through Defender tasks
for %%T in (
    "Microsoft\Windows Defender\Scheduled Scan"
    "Microsoft\Windows Defender\Verification"
    "Microsoft\Windows Defender\Windows Defender Cache Maintenance"
    "Microsoft\Windows Defender\Windows Defender Cleanup"
    "Microsoft\Windows Defender\Windows Defender Scheduled Scan"
    "Microsoft\Windows Defender\Windows Defender Verification"
) do (
    schtasks /Change /TN %%T /Disable >nul 2>&1
)

echo [*] Removing Defender context menu entries...

reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1

echo [*] Hiding Antivirus UI section from Windows Security (Win10/11)...

reg add "HKLM\SOFTWARE\Microsoft\Windows Security Health\State" /v DisableAVCheck /t REG_DWORD /d 1 /f >nul

echo.
echo [+] Windows Defender components have been disabled and removed.
echo [+] Please reboot your computer to complete the process.
pause
exit /b
