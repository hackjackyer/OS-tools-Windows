@echo off&setlocal enabledelayedexpansion
color 2f&mode con cols=60 lines=10
title У���ļ�
::by hackjackyer
set batpath=%~dp0
echo ��ѱ��������fciv.exe�ļ��ŵ�ͬһĿ¼���Ҹ�Ŀ¼��ҪУ����ļ����ϼ�Ŀ¼
set /p dirpath=�������ļ�������
echo.>MD5_SHA1.txt
cls
echo.
echo У���ļ���Ϣ�С���
for /f "delims=" %%i in ('dir /b /s /a-d %dirpath%') do (pushd %%~dpi
set xiangdui=%%~dpi
set xiangdui=!xiangdui:%cd%\=!
rename "%%i" hackjackyer.txt
echo =========================!xiangdui!%%~nxi=========================>>"%batpath%MD5_SHA1.txt"
echo                 MD5                             SHA-1>>"%batpath%MD5_SHA1.txt"
for /f "tokens=1,2 delims= " %%j in ('%batpath%fciv hackjackyer.txt -both^|find "hackjackyer.txt"') do (echo %%j %%k>>"%batpath%MD5_SHA1.txt")
rename hackjackyer.txt "%%~nxi"
echo.>>"%batpath%MD5_SHA1.txt")
cls
echo.
echo У�����
ping -n 4 127.0.0.1 >nul
start "" notepad "%batpath%MD5_SHA1.txt"
exit
