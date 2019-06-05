@echo off
set "_FilePath=%~f0"
setlocal EnableExtensions EnableDelayedExpansion
:: Get Administrator Rights
fltmc >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\GetAdmin.vbs"
    echo UAC.ShellExecute "!_FilePath!", "", "", "runas", 1 >> "%temp%\GetAdmin.vbs"
    "%temp%\GetAdmin.vbs"
    del /f /q "%temp%\GetAdmin.vbs" >nul 2>&1
    exit
)
schtasks /Run /TN \Microsoft\Windows\TextServicesFramework\MsCtfMonitor
echo 修复完成
ping -n 3 127.0.0.1 >nul