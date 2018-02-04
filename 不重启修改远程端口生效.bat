@echo off
color 0a
setlocal EnableExtensions EnableDelayedExpansion
title @@ 修改Windows远程桌面服务端口号 @@
echo *******************************************************************
echo * 键入您要更改的远程桌面端口号，范围：1-65535，不能与其他端口冲突 *
echo *******************************************************************
echo.
set /p port=请输入端口号：
cls
echo 关闭远程服务（此时你会断开了。请用10秒后用新远程端口%port%远程）
sc stop UmRdpService
ping -n 4 127.0.0.1>nul
sc stop TermService
ping -n 4 127.0.0.1>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t reg_dword /d %port% /f
::reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /f
cls
echo 开启远程服务
sc start TermService
ping -n 4 127.0.0.1>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
