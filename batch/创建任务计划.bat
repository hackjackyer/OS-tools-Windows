@echo off
rem 开启防火墙服务
call :configsv MpsSvc
rem 开启任务计划服务
call :configsv Schedule

rem 放行ftp程序
netsh advfirewall firewall add rule name=文件传送程序 program="C:\windows\system32\ftp.exe" dir=in action=allow protocol=TCP
netsh advfirewall firewall add rule name=文件传送程序 program="C:\windows\system32\ftp.exe" dir=in action=allow protocol=UDP


mkdir D:\签到记录
copy Z:\bat\签到记录.bat D:\网维签到记录 /y

cls
echo.
echo.
set /p panduan=添加还是删除任务计划（Y添加，N删除）:
if /i %panduan% == y call :tianjia
if /i %panduan% == n call :shanchu

::=====================================设置快捷方式
echo Dim WshShell,Shortcut>D:\签到记录\kuaijiefangshi.vbs 
echo Dim path,fso>>D:\签到记录\kuaijiefangshi.vbs
echo path="D:\签到记录\签到记录.bat">>D:\签到记录\kuaijiefangshi.vbs
echo Set fso=CreateObject^("Scripting.FileSystemObject"^)>>D:\签到记录\kuaijiefangshi.vbs 
echo Set WshShell=WScript.CreateObject^("WScript.Shell"^)>>D:\签到记录\kuaijiefangshi.vbs 
echo Set Shortcut=WshShell.CreateShortCut^("%userprofile%/desktop/签到记录.lnk"^)>>D:\签到记录\kuaijiefangshi.vbs 
echo Shortcut.TargetPath=path>>D:\签到记录\kuaijiefangshi.vbs 
echo Shortcut.Save>>D:\签到记录\kuaijiefangshi.vbs
start "%SystemRoot%\System32\WScript.exe" "D:\签到记录\kuaijiefangshi.vbs"

exit

:tianjia
schtasks /delete /tn "\xiaoyu\qiandao" /F
rem 设置，从凌晨2点开始，每隔8个小时，运行签到批处理
schtasks /create /sc HOURLY /mo 8 /tn "\xiaoyu\qiandao" /st 02:00:00 /tr "cmd /c D:\签到记录\签到记录.bat"
exit /b

:shanchu
schtasks /delete /tn "\xiaoyu\qiandao" /F
exit /b

:configsv
sc config %1% start= auto && sc start %1%
exit /b

