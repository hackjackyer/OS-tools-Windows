@Echo off
::by hackjackyer
setlocal enabledelayedexpansion
set "setuppath=%~d0"
Color A

if not exist "iis6" (
        echo ����:û�з���IIS6��װ�ļ����뽫���ļ�������IIS6ͬ��Ŀ¼
        pause
        exit
)

@xcopy iis6 "%setuppath%\i386" /d /c /i /y>nul

:: *******************
:: * �޸�Ĭ�ϰ�װ·��
:: *******************
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v SourcePath /t REG_SZ /f /d "%setuppath%\\"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v ServicePackSourcePath /t REG_SZ /f /d "%setuppath%\\"

TITLE С��IIS6һ����װ��
:: *******************
:: * ��װ������IE��ǿ
:: *******************
:Install
Cls
@echo. && @echo ��װ���ڽ�����...
:: ���� IIS 6.0 ��װ�ű������� ASP��ASP.NET
@echo [Components]> %TEMP%\IIS_Install.txt
@echo iis_common = ON>> %TEMP%\IIS_Install.txt
@echo iis_www = ON>> %TEMP%\IIS_Install.txt
@echo iis_asp = ON>> %TEMP%\IIS_Install.txt
@echo iis_inetmgr = ON>> %TEMP%\IIS_Install.txt
@echo aspnet = ON>> %TEMP%\IIS_Install.txt
@echo IEHardenUser = OFF>> %TEMP%\IIS_Install.txt
@echo IEHardenAdmin = OFF>> %TEMP%\IIS_Install.txt
:: ��װ IIS 6.0
%windir%\System32\Sysocmgr.exe /i:sysoc.inf /u:%TEMP%\IIS_Install.txt /q
del /q /f %windir%\*.log >nul 2>nul
del /q /f %TEMP%\IIS_Install.txt >nul 2>nul
del /q /f %TEMP%\ASPNETSetup.log >nul 2>nul
:: ���� IIS ���ø�·��
@cscript /nologo C:\Inetpub\AdminScripts\adsutil.vbs set W3SVC/AspEnableParentPaths 1 >nul 2>nul
copy "%allusersprofile%\����ʼ���˵�\����\������\Internet ��Ϣ����(IIS)������.lnk" "%userprofile%\����\"
Goto Install_End

:Install_End 
Cls
Color B
@echo. && @echo. && @echo ��װ��������������˳���
Pause >nul 2>nul
:: ɾ����װ�ļ�
:: del %0 >nul 2>nul  
Exit
