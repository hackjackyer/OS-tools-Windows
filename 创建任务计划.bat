@echo off
rem ��������ǽ����
call :configsv MpsSvc
rem ��������ƻ�����
call :configsv Schedule

rem ����ftp����
netsh advfirewall firewall add rule name=�ļ����ͳ��� program="C:\windows\system32\ftp.exe" dir=in action=allow protocol=TCP
netsh advfirewall firewall add rule name=�ļ����ͳ��� program="C:\windows\system32\ftp.exe" dir=in action=allow protocol=UDP


mkdir D:\ǩ����¼
copy Z:\bat\ǩ����¼.bat D:\��άǩ����¼ /y

cls
echo.
echo.
set /p panduan=��ӻ���ɾ������ƻ���Y��ӣ�Nɾ����:
if /i %panduan% == y call :tianjia
if /i %panduan% == n call :shanchu

::=====================================���ÿ�ݷ�ʽ
echo Dim WshShell,Shortcut>D:\ǩ����¼\kuaijiefangshi.vbs 
echo Dim path,fso>>D:\ǩ����¼\kuaijiefangshi.vbs
echo path="D:\ǩ����¼\ǩ����¼.bat">>D:\ǩ����¼\kuaijiefangshi.vbs
echo Set fso=CreateObject^("Scripting.FileSystemObject"^)>>D:\ǩ����¼\kuaijiefangshi.vbs 
echo Set WshShell=WScript.CreateObject^("WScript.Shell"^)>>D:\ǩ����¼\kuaijiefangshi.vbs 
echo Set Shortcut=WshShell.CreateShortCut^("%userprofile%/desktop/ǩ����¼.lnk"^)>>D:\ǩ����¼\kuaijiefangshi.vbs 
echo Shortcut.TargetPath=path>>D:\ǩ����¼\kuaijiefangshi.vbs 
echo Shortcut.Save>>D:\ǩ����¼\kuaijiefangshi.vbs
start "%SystemRoot%\System32\WScript.exe" "D:\ǩ����¼\kuaijiefangshi.vbs"

exit

:tianjia
schtasks /delete /tn "\xiaoyu\qiandao" /F
rem ���ã����賿2�㿪ʼ��ÿ��8��Сʱ������ǩ��������
schtasks /create /sc HOURLY /mo 8 /tn "\xiaoyu\qiandao" /st 02:00:00 /tr "cmd /c D:\ǩ����¼\ǩ����¼.bat"
exit /b

:shanchu
schtasks /delete /tn "\xiaoyu\qiandao" /F
exit /b

:configsv
sc config %1% start= auto && sc start %1%
exit /b

