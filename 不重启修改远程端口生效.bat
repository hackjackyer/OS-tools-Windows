@echo off
color 0a
setlocal EnableExtensions EnableDelayedExpansion
title @@ �޸�WindowsԶ���������˿ں� @@
echo *******************************************************************
echo * ������Ҫ���ĵ�Զ������˿ںţ���Χ��1-65535�������������˿ڳ�ͻ *
echo *******************************************************************
echo.
set /p port=������˿ںţ�
cls
echo �ر�Զ�̷��񣨴�ʱ���Ͽ��ˡ�����10�������Զ�̶˿�%port%Զ�̣�
sc stop UmRdpService
ping -n 4 127.0.0.1>nul
sc stop TermService
ping -n 4 127.0.0.1>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t reg_dword /d %port% /f
::reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /f
cls
echo ����Զ�̷���
sc start TermService
ping -n 4 127.0.0.1>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
