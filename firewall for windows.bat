@echo off
title ��������ǽ����Ĭ�Ϸ���Զ�̶˿ڣ���Ҫ����Զ�̲��ϣ�
color 2f
setlocal EnableExtensions EnableDelayedExpansion
:: ��ȡԶ�̶˿ںţ���Ϊ��ȡ����16���Ƶ�ֵ��������set /a�������������10���ơ�
for /f "tokens=3 delims= " %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" ^|find /i "PortNumber"') do set /a RDport=%%a

:: Get Architecture of the OS installed; OS Locale/Language Independent from Windows XP / Server 2003 and Later
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Processor get AddressWidth /value') do (
    set _OSarch=%%aλ
)
:: Get Windows OS version information and goto Respective Function
for /f "tokens=2 delims==" %%a in ('wmic path Win32_OperatingSystem get BuildNumber /value') do (
    set /a _WinBuild=%%a
)
if %_WinBuild% GEQ 7600 (
    echo ����׼���У������Եȡ���
    goto :Win7AndLater
) else if %_WinBuild% GEQ 2600 (
    echo ����׼���У������Եȡ���
    goto :VistaAndBelow
) else (
    echo �˳������ô˲���ϵͳ
    echo ��������˳� exit...
    pause >nul
    exit
)

:Win7AndLater
cls
echo Win7AndLater
echo.
echo ��ǰԶ�̶˿���%RDport%
echo.
echo ��ǰϵͳ��!_OSarch!ϵͳ
echo.
echo ��ǰϵͳ�汾��!_WinBuild!
echo.
echo ------------------------------------------
echo ��ѡ��Ҫ���еĲ����������Ӧ�����֣��س����ɣ�
echo.
echo 1.��ping
echo.
echo 2.���ж˿�
echo.
echo 3.��ֹ�˿�
echo.
echo 4.�رշ���ǽ
echo.
echo 5.�˳�
echo.
echo ------------------------------------------
set /p choi=����������ѡ��

if %choi% equ 1 goto :DenyICMP
if %choi% equ 2 goto :Allowport
if %choi% equ 3 goto :DenyPort
if %choi% equ 4 goto :CloseFW
if %choi% equ 5 exit
pause
exit

::============================================================
:DenyICMP
call :ENABLEFW
netsh advfirewall firewall add rule name="DenyICMPv4" dir=in protocol=icmpv4 action=block enable=yes
cls
echo.
echo ��ping��
echo.
pause
goto :Win7AndLater
::============================================================
:Allowport
cls
call :ENABLEFW
echo Ĭ�϶��Ƿ���tcpЭ��Ķ˿ڣ�֧�ַ�Χ�������80-90�����Է���80-90�����ж˿�
set /p port=������Ҫ���еĶ˿ںţ�
netsh advfirewall firewall delete rule name="����TCP%port%"
netsh advfirewall firewall add rule name="����TCP%port%" protocol=TCP localport=%port% dir=in action=allow
cls
echo.
echo ����TCP%port%�˿���
echo.
pause
goto :Win7AndLater
::============================================================
:DenyPort
cls
call :ENABLEFW
echo Ĭ�϶��ǽ�ֹtcpЭ��Ķ˿ڣ�֧�ַ�Χ�������80-90�����Է���80-90�����ж˿�
set /p port=������Ҫ��ֹ�Ķ˿ںţ�
netsh advfirewall firewall delete rule name="��ֹTCP%port%"
netsh advfirewall firewall add rule name="��ֹTCP%port%" protocol=TCP localport=%port% dir=in action=block
cls
echo.
echo ��ֹTCP%port%�˿���
echo.
pause
goto :Win7AndLater
::============================================================
:CloseFW
cls
netsh advfirewall set currentprofile state off
cls
echo.
echo �رշ���ǽ��
echo.
pause
goto :Win7AndLater
::============================================================
::���÷���ǽ
:ENABLEFW
netsh advfirewall set currentprofile state on
exit /b

::============================================================
::============================================================
::============================================================

:VistaAndBelow
cls
echo VistaAndBelow
echo.
echo ��ǰԶ�̶˿���%RDport%
echo.
echo ��ǰϵͳ��!_OSarch!ϵͳ
echo.
echo ��ǰϵͳ�汾��!_WinBuild!
echo.
echo ------------------------------------------
echo ��ѡ��Ҫ���еĲ����������Ӧ�����֣��س����ɣ�
echo.
echo 1.��ping
echo.
echo 2.���ж˿�
echo.
echo 3.��ֹ�˿�
echo.
echo 4.�رշ���ǽ
echo.
echo 5.�˳�
echo.
echo ------------------------------------------
set /p chois=����������ѡ��

if %chois% equ 1 goto :DenyICMPb
if %chois% equ 2 goto :Allowportb
if %chois% equ 3 goto :DenyPortb
if %chois% equ 4 goto :CloseFWb
if %chois% equ 5 exit
pause
exit
::============================================================
:DenyICMPb
cls
call :ENABLEFWb
netsh firewall set icmpsetting type=ALL mode=disable
cls
echo.
echo ��ping�������
echo.
pause
goto :VistaAndBelow
::============================================================
:Allowportb
cls
set /p port=������Ҫ���еĶ˿ںţ�Ĭ�϶��Ƿ���tcpЭ��Ķ˿ڣ���
call :ENABLEFWb
netsh firewall add portopening tcp %port% ����TCP%port%�˿�
cls
echo.
echo ����TCP%port%�˿���
echo.
pause
goto :VistaAndBelow
::============================================================
:DenyPortb
cls
set /p port=������Ҫ��ֹ�Ķ˿ںţ�Ĭ�϶��ǽ�ֹtcpЭ��Ķ˿ڣ���
call :ENABLEFWb
netsh firewall delete portopening tcp %port%
cls
echo.
echo ��ֹTCP%port%�˿���
echo.
pause
goto :VistaAndBelow
::============================================================
:CloseFWb
cls
netsh firewall set opmode mode = disable
cls
echo.
echo �رշ���ǽ��
echo.
pause
goto :VistaAndBelow
::============================================================
::���÷���ǽ
:ENABLEFWb
netsh firewall set opmode mode = enable
netsh firewall set service remotedesktop enable
netsh firewall set portopening tcp %RDport% enable
exit /b
::============================================================
