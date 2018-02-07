@echo off
title 清理挖矿病毒【请以管理员权限运行本程序】
color 2f
setlocal EnableExtensions EnableDelayedExpansion
:: Get Administrator Rights
fltmc >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\GetAdmin.vbs"
    echo UAC.ShellExecute "!_FilePath!", "", "", "runas", 1 >> "%temp%\GetAdmin.vbs"
    "%temp%\GetAdmin.vbs"
    del /f /q "%temp%\GetAdmin.vbs" >nul 2>&1
    exit
)

echo 停止挖矿进程xmrig.exe
taskkill /F /T /im xmrig.exe&&echo 已关闭挖矿进程！
echo.
echo清理相关文件
del c:\windows\cmd.reg /f /q
del c:\windows\cmd.vbs /f /q
del c:\windows\jt.bat /f /q
del c:\windows\xm.bat /f /q
del c:\windows\xmrig.exe /f /q
reg delete "HKLM\software\microsoft\windows\currentversion\run" /v Tomcat /f
cls
echo.
echo 清理完毕！
echo 本次清理删除了以下文件
echo.
echo c:\windows\cmd.reg
echo c:\windows\cmd.vbs
echo c:\windows\jt.bat
echo c:\windows\xm.bat
echo c:\windows\xmrig.exe
echo.
echo 本次清理了下面的注册表值
echo HKLM\software\microsoft\windows\currentversion\run下面的tomcat
pause
exit