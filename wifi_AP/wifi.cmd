@ECHO OFF
Title �����ȵ����ù���
color 0a
Pushd %~dp0
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set b=%SystemRoot%\SysWOW64) Else (Set b=%SystemRoot%\system32)
Rd "%b%\test_permission_test" >nul 2>nul
Md "%b%\test_permission_test" 2>nul||(Echo ��ʹ���Ҽ�����Ա�������&&Pause >nul&&Exit)
Rd "%b%\test_permission_test" >nul 2>nul
setlocal ENABLEDELAYEDEXPANSION

GOTO MENU
:MENU
cls
ECHO.
ECHO.          =-=-=-=-=��ѡ��Ҫ�����������ȵ㣨wifi��������Ŀ=-=-=-=-=
ECHO.
ECHO.                       1  �鿴���������Ƿ�֧��wifi�ȵ㹦��
Echo.
ECHO.                       2  ��һ�����ò�����wifi�ȵ�
ECHO.
ECHO.                       3  �������е�wifi�ȵ�
ECHO.
ECHO.                       4  �鿴wifi��Ϣ
ECHO.          
ECHO.                       5  �ر�wifi�ȵ�
ECHO.
ECHO.                       x  ��     ��
ECHO.
ECHO.
ECHO.
ECHO.

Set /p c=���������ֲ���Enterȷ����
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
ECHO =-=-=-=-=�������������Ƿ�֧��wifi�ȵ㹦�ܣ�=-=-=-=-=
ECHO.
ECHO.
IF EXIST "%b%\netsh.exe" netsh interface set interface name="������������" admin=ENABLED
Set supportWifi="false"
netsh wlan show drivers | find "֧�ֵĳ�������  : ��" >nul&&If "1"=="1" (Set supportWifi="true")
if %supportWifi%=="true" (set/p=<nul&echo.> ��ϲ����������������֧��wifi�ȵ㹦�ܣ��Ͽ�ȥ�����ɣ���&findstr /a:0c .* ��ϲ����*&del ��ϲ����*) else (set/p=<nul&echo.> ���ź�����������������֧��wifi�ȵ㹦�ܣ��������������԰ѣ���&findstr /a:0c .* ���ź���*&del ���ź���*) 
echo.
ECHO.
ECHO.
pause
GOTO MENU


:wifi_config
cls
ECHO. =-=-=-=-=����һ�������ȵ�=-=-=-=-=
ECHO.
echo ��һ����������SSID Enter����
echo.
:begin
set /p SSID=��������SSID��
if "%SSID:~1,1%"==""  echo ��������2λ&goto begin
echo.
echo.
echo.
echo.
:key
echo �ڶ���������8λ���������� Enter����
echo.
set /p pw=����������(8-16λ)��
if "%pw:~7,1%"==""  echo ��������8λ&goto key
if "%pw:~16,1%" neq "" echo ����16λ��&goto key
echo ^[WLAN_SSID^]>config.ini
echo WLAN_SSID^=%SSID%>>config.ini
echo.>>config.ini
echo ^[WLAN_PASSWORD^]>>config.ini
echo WLAN_PASSWORD^=%PW%>>config.ini
echo.>>config.ini
echo.
netsh interface set interface name="������������" admin=ENABLED
netsh wlan set hostednetwork mode=allow
netsh wlan set hostednetwork ssid=%SSID% key=%PW%
netsh wlan start hostednetwork
echo ���ڲ��ҵ�ǰ����ʹ�õ���������,���Ե�....
Getmac /v /nh /fo csv | find /i "Device" > network_all.txt
ping 127.0.0.1>nul
for /f "tokens=1-3* delims=," %%a in (network_all.txt) do if not "%%d"==""ý�屻�Ͽ�"" (
    set myname=%%a
    rem ����:%%b
    set mymac=%%c
    rem Э��:%%d
)
set myname=%myname:~1,-1%
set mymac=%mymac:~1,-1%
echo ��ǰmacΪ%mymac%���������ƽ���"%myname%"
echo.
netsh interface set interface name="%myname%" newname="wlan_ap"
net start MpsSvc
cscript /nologo "%~dp0\ics.vbs" "wlan_ap" "��������" "on">ics.log
net stop MpsSvc
set/p=<nul&echo.>��ϲ����wifi������Ѿ��������&findstr /a:0e .*  ��ϲ����wifi������Ѿ��������*&del ��ϲ����wifi������Ѿ��������*
ECHO.
set/p=<nul&echo.>��SSID��"%ssid%"���룺"%pw%"��&findstr /a:0c .*  ��SSID��*&del ��SSID��*
ECHO.
ECHO.
pause
GOTO MENU

:wifi_start
cls
if exist config.ini (echo �����ļ���ȷ��...) else (goto wifi_config)
FOR /F "tokens=1,2 delims==" %%i in (config.ini) DO (
SET %%i=%%j
)
netsh interface set interface name="������������" admin=ENABLED
netsh wlan set hostednetwork mode=allow
netsh wlan set hostednetwork ssid=%WLAN_SSID% key=%WLAN_PASSWORD%
netsh wlan start hostednetwork
net start MpsSvc
cscript /nologo "%~dp0\ics.vbs" "wlan_ap" "��������" "on">ics.log
net stop MpsSvc
set/p=<nul&echo.>��ϲ����wifi������Ѿ��������&findstr /a:0e .*  ��ϲ����wifi������Ѿ��������*&del ��ϲ����wifi������Ѿ��������*
ECHO.
set/p=<nul&echo.>��SSID��"%WLAN_SSID%"���룺"%WLAN_PASSWORD%"��&findstr /a:0c .*  ��SSID��*&del ��SSID��*
ECHO.
pause
GOTO MENU


:wifi_show
cls
ECHO. =-=-=-=-=wifi�ȵ�״̬=-=-=-=-=
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
ECHO. =-=-=-=-=�ر������ȵ����=-=-=-=-=
ECHO.
for /f "tokens=1* delims=:" %%i in ('findstr /inc:"Enabling public" ics.log') do set /a N=%%i-5
for /f "tokens=1,2* delims=: " %%i in ('findstr /in ".*" "ics.log"') do if %%i equ %N% set str=%%k&goto icslog
:icslog
cscript /nologo "%~dp0\ics.vbs"  "wlan_ap" "%str%" "off" >nul
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
netsh interface set interface name="������������" admin=DISABLED
ECHO.
net stop MpsSvc
set/p=<nul&echo.>wifi�ȵ㹦���Ѿ��ɹ��رգ�����&findstr /a:0c .*  wifi�ȵ�*&del wifi�ȵ�*
ECHO.
ECHO.
pause
GOTO MENU


:Exit
cls