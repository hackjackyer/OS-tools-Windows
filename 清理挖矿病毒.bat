@echo off
title �����ڿ󲡶������Թ���ԱȨ�����б�����
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

echo ֹͣ�ڿ����xmrig.exe
taskkill /F /T /im xmrig.exe&&echo �ѹر��ڿ���̣�
echo.
echo��������ļ�
del c:\windows\cmd.reg /f /q
del c:\windows\cmd.vbs /f /q
del c:\windows\jt.bat /f /q
del c:\windows\xm.bat /f /q
del c:\windows\xmrig.exe /f /q
reg delete "HKLM\software\microsoft\windows\currentversion\run" /v Tomcat /f
cls
echo.
echo ������ϣ�
echo ��������ɾ���������ļ�
echo.
echo c:\windows\cmd.reg
echo c:\windows\cmd.vbs
echo c:\windows\jt.bat
echo c:\windows\xm.bat
echo c:\windows\xmrig.exe
echo.
echo ���������������ע���ֵ
echo HKLM\software\microsoft\windows\currentversion\run�����tomcat
pause
exit