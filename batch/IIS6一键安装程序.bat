@Echo off
::by hackjackyer
setlocal enabledelayedexpansion
set "setuppath=%~d0"
Color A

if not exist "iis6" (
        echo 错误:没有发现IIS6安装文件，请将此文件放置与IIS6同级目录
        pause
        exit
)

@xcopy iis6 "%setuppath%\i386" /d /c /i /y>nul

:: *******************
:: * 修改默认安装路径
:: *******************
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v SourcePath /t REG_SZ /f /d "%setuppath%\\"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v ServicePackSourcePath /t REG_SZ /f /d "%setuppath%\\"

TITLE 小于IIS6一键安装器
:: *******************
:: * 安装并禁用IE增强
:: *******************
:Install
Cls
@echo. && @echo 安装正在进行中...
:: 生成 IIS 6.0 安装脚本，启用 ASP，ASP.NET
@echo [Components]> %TEMP%\IIS_Install.txt
@echo iis_common = ON>> %TEMP%\IIS_Install.txt
@echo iis_www = ON>> %TEMP%\IIS_Install.txt
@echo iis_asp = ON>> %TEMP%\IIS_Install.txt
@echo iis_inetmgr = ON>> %TEMP%\IIS_Install.txt
@echo aspnet = ON>> %TEMP%\IIS_Install.txt
@echo IEHardenUser = OFF>> %TEMP%\IIS_Install.txt
@echo IEHardenAdmin = OFF>> %TEMP%\IIS_Install.txt
:: 安装 IIS 6.0
%windir%\System32\Sysocmgr.exe /i:sysoc.inf /u:%TEMP%\IIS_Install.txt /q
del /q /f %windir%\*.log >nul 2>nul
del /q /f %TEMP%\IIS_Install.txt >nul 2>nul
del /q /f %TEMP%\ASPNETSetup.log >nul 2>nul
:: 配置 IIS 启用父路径
@cscript /nologo C:\Inetpub\AdminScripts\adsutil.vbs set W3SVC/AspEnableParentPaths 1 >nul 2>nul
copy "%allusersprofile%\「开始」菜单\程序\管理工具\Internet 信息服务(IIS)管理器.lnk" "%userprofile%\桌面\"
Goto Install_End

:Install_End 
Cls
Color B
@echo. && @echo. && @echo 安装结束，按任意键退出！
Pause >nul 2>nul
:: 删除安装文件
:: del %0 >nul 2>nul  
Exit