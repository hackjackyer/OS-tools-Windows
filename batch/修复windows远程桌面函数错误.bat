@echo off
title 修复Windows远程出现函数错误
::by xiaoyu QQ:1014809081
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2 /f
cls
echo.
echo 手动修复参考链接https://support.microsoft.com/zh-cn/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018
echo.
echo.
echo ############################
echo #  修复完成，需要重启生效  #
echo ############################
pause
exit