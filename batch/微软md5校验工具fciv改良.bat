@echo off&setlocal enabledelayedexpansion
color 2f&mode con cols=60 lines=10
title 校验文件
::by hackjackyer
set batpath=%~dp0
echo 请把本批处理和fciv.exe文件放到同一目录，且该目录是要校验的文件的上级目录
set /p dirpath=请输入文件夹名：
echo.>MD5_SHA1.txt
cls
echo.
echo 校验文件信息中……
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
echo 校验结束
ping -n 4 127.0.0.1 >nul
start "" notepad "%batpath%MD5_SHA1.txt"
exit
