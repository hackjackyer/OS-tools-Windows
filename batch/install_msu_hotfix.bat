@echo off
title С��msu��ʽ������װ��
::hackjackyer

set kbfile=kb_list_xiaoyu.txt
dir 3>%kbfile%
cls

echo == ��ط������� ==
ping -n 10 127.0.0.1>nul
sc config wuauserv start= demand>nul
net start wuauserv>nul

echo.
echo == ��ʼ��װ���� ==
for /f %%a in ('dir /b *.msu') do (
    echo "%%a" ...
    ping -n 5 127.0.0.1>nul
    C:\Windows\system32\wusa.exe %%a /quiet /norestart
    for /f "delims=- tokens=2" %%b in ("%%a") do echo %%b>>%kbfile%
)

cmd /c systeminfo |findstr /i kb>all_xiaoyu.txt
for /f "tokens=2 delims= " %%a in (all_xiaoyu.txt) do (
    for /f "tokens=* delims= " %%b in ("%%a") do echo %%b>>kb_all_xiaoyu.txt
)

cls
echo.
echo == ��װ��� ==
echo ���ΰ�װ�����в���:
findstr /belig:kb_all_xiaoyu.txt %kbfile%
findstr /belvig:kb_all_xiaoyu.txt %kbfile%>nul
if %errorlevel%==0 (
    echo == ���в���δ��װ ==
    echo ���ֶ���װ���鿴ԭ��
    findstr /belvig:kb_all_xiaoyu.txt %kbfile%
)
echo.
::debug
del *.txt /f /q
pause
