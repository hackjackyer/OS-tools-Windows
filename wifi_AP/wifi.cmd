@ECHO OFF
Title 无线热点设置工具
color 0a
Pushd %~dp0
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set b=%SystemRoot%\SysWOW64) Else (Set b=%SystemRoot%\system32)
Rd "%b%\test_permission_test" >nul 2>nul
Md "%b%\test_permission_test" 2>nul||(Echo 请使用右键管理员身份运行&&Pause >nul&&Exit)
Rd "%b%\test_permission_test" >nul 2>nul
setlocal ENABLEDELAYEDEXPANSION

GOTO MENU
:MENU
cls
ECHO.
ECHO.          =-=-=-=-=请选择要启动的无线热点（wifi）服务项目=-=-=-=-=
ECHO.
ECHO.                       1  查看无线网卡是否支持wifi热点功能
Echo.
ECHO.                       2  第一次配置并开启wifi热点
ECHO.
ECHO.                       3  开启已有的wifi热点
ECHO.
ECHO.                       4  查看wifi信息
ECHO.          
ECHO.                       5  关闭wifi热点
ECHO.
ECHO.                       x  退     出
ECHO.
ECHO.
ECHO.
ECHO.

Set /p c=请输入数字并按Enter确定：
IF NOT "%c%"=="" SET c=%c:~0,1%
If "%c%"=="1" Goto wifi_verify
If "%c%"=="2" Goto wifi_config
If "%c%"=="3" Goto wifi_start
If "%c%"=="4" Goto wifi_show
If "%c%"=="5" Goto wifi_stop
If "%c%"=="x" Goto exit
GOTO MENU

:wifi_verify
cls
ECHO =-=-=-=-=您的无线网卡是否支持wifi热点功能？=-=-=-=-=
ECHO.
ECHO.
IF EXIST "%b%\netsh.exe" netsh interface set interface name="无线网络连接" admin=ENABLED
Set supportWifi="false"
netsh wlan show drivers | find "支持的承载网络  : 是" >nul&&If "1"=="1" (Set supportWifi="true")
if %supportWifi%=="true" (set/p=<nul&echo.> 恭喜您！您的无线网卡支持wifi热点功能，赶快去开启吧！！&findstr /a:0c .* 恭喜您！*&del 恭喜您！*) else (set/p=<nul&echo.> 很遗憾！您的无线网卡不支持wifi热点功能，换块网卡再试试把！！&findstr /a:0c .* 很遗憾！*&del 很遗憾！*) 
echo.
ECHO.
ECHO.
pause
GOTO MENU


:wifi_config
cls
ECHO. =-=-=-=-=创建一个无线热点=-=-=-=-=
ECHO.
echo 第一步：输入新SSID Enter结束
echo.
:begin
set /p SSID=请输入新SSID：
if "%SSID:~1,1%"==""  echo 最少输入2位&goto begin
echo.
echo.
echo.
echo.
:key
echo 第二步：输入8位以上新密码 Enter结束
echo.
set /p pw=请输入密码(8-16位)：
if "%pw:~7,1%"==""  echo 最少输入8位&goto key
if "%pw:~16,1%" neq "" echo 超过16位了&goto key
echo ^[WLAN_SSID^]>config.ini
echo WLAN_SSID^=%SSID%>>config.ini
echo.>>config.ini
echo ^[WLAN_PASSWORD^]>>config.ini
echo WLAN_PASSWORD^=%PW%>>config.ini
echo.>>config.ini
echo.
netsh interface set interface name="无线网络连接" admin=ENABLED
netsh wlan set hostednetwork mode=allow
netsh wlan set hostednetwork ssid=%SSID% key=%PW%
netsh wlan start hostednetwork
echo 正在查找当前正在使用的网络名称,请稍等....
Getmac /v /nh /fo csv | find /i "Device" > network_all.txt
ping 127.0.0.1>nul
for /f "tokens=1-3* delims=," %%a in (network_all.txt) do if not "%%d"==""媒体被断开"" (
    set myname=%%a
    rem 网卡:%%b
    set mymac=%%c
    rem 协议:%%d
)
set myname=%myname:~1,-1%
set mymac=%mymac:~1,-1%
echo 当前mac为%mymac%，网卡名称叫做"%myname%"
echo.
netsh interface set interface name="%myname%" newname="wlan_ap"
net start MpsSvc
cscript /nologo "%~dp0\ics.vbs" "wlan_ap" "本地连接" "on">ics.log
net stop MpsSvc
set/p=<nul&echo.>恭喜！！wifi接入点已经设置完成&findstr /a:0e .*  恭喜！！wifi接入点已经设置完成*&del 恭喜！！wifi接入点已经设置完成*
ECHO.
set/p=<nul&echo.>【SSID："%ssid%"密码："%pw%"】&findstr /a:0c .*  【SSID：*&del 【SSID：*
ECHO.
ECHO.
pause
GOTO MENU

:wifi_start
cls
if exist config.ini (echo 配置文件已确认...) else (goto wifi_config)
FOR /F "tokens=1,2 delims==" %%i in (config.ini) DO (
SET %%i=%%j
)
netsh interface set interface name="无线网络连接" admin=ENABLED
netsh wlan set hostednetwork mode=allow
netsh wlan set hostednetwork ssid=%WLAN_SSID% key=%WLAN_PASSWORD%
netsh wlan start hostednetwork
net start MpsSvc
cscript /nologo "%~dp0\ics.vbs" "wlan_ap" "本地连接" "on">ics.log
net stop MpsSvc
set/p=<nul&echo.>恭喜！！wifi接入点已经设置完成&findstr /a:0e .*  恭喜！！wifi接入点已经设置完成*&del 恭喜！！wifi接入点已经设置完成*
ECHO.
set/p=<nul&echo.>【SSID："%WLAN_SSID%"密码："%WLAN_PASSWORD%"】&findstr /a:0c .*  【SSID：*&del 【SSID：*
ECHO.
pause
GOTO MENU


:wifi_show
cls
ECHO. =-=-=-=-=wifi热点状态=-=-=-=-=
ECHO.
ECHO.
netsh wlan show hostednetwork
ECHO.
ECHO.
ECHO.
ECHO.
pause
GOTO MENU

:wifi_stop
ECHO. =-=-=-=-=关闭无线热点服务=-=-=-=-=
ECHO.
for /f "tokens=1* delims=:" %%i in ('findstr /inc:"Enabling public" ics.log') do set /a N=%%i-5
for /f "tokens=1,2* delims=: " %%i in ('findstr /in ".*" "ics.log"') do if %%i equ %N% set str=%%k&goto icslog
:icslog
cscript /nologo "%~dp0\ics.vbs"  "wlan_ap" "%str%" "off" >nul
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
netsh interface set interface name="无线网络连接" admin=DISABLED
ECHO.
net stop MpsSvc
set/p=<nul&echo.>wifi热点功能已经成功关闭！！！&findstr /a:0c .*  wifi热点*&del wifi热点*
ECHO.
ECHO.
pause
GOTO MENU


:Exit
cls