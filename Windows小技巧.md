Windows小技巧
===

Change users path
---

1. install OS before input user and password
2. shift + F10 = cmd

```bat
robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ
rmdir "C:\Users" /S /Q
mklink /J "C:\Users" "D:\Users"
```

管理员运行bat
---

```bat
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
```
