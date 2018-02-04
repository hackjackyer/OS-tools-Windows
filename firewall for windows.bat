@echo off
title 操作防火墙（会默认放行远程端口，不要担心远程不上）
color 2f
setlocal EnableExtensions EnableDelayedExpansion
:: 获取远程端口号，因为获取的是16进制的值，所以用set /a参数，来换算成10进制。
for /f "tokens=3 delims= " %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" ^|find /i "PortNumber"') do set /a RDport=%%a

:: Get Architecture of the OS installed; OS Locale/Language Independent from Windows XP / Server 2003 and Later
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Processor get AddressWidth /value') do (
    set _OSarch=%%a位
)
:: Get Windows OS version information and goto Respective Function
for /f "tokens=2 delims==" %%a in ('wmic path Win32_OperatingSystem get BuildNumber /value') do (
    set /a _WinBuild=%%a
)
if %_WinBuild% GEQ 7600 (
    echo 程序准备中，请是稍等……
    goto :Win7AndLater
) else if %_WinBuild% GEQ 2600 (
    echo 程序准备中，请是稍等……
    goto :VistaAndBelow
) else (
    echo 此程序不适用此操作系统
    echo 按任意键退出 exit...
    pause >nul
    exit
)

:Win7AndLater
cls
echo Win7AndLater
echo.
echo 当前远程端口是%RDport%
echo.
echo 当前系统是!_OSarch!系统
echo.
echo 当前系统版本是!_WinBuild!
echo.
echo ------------------------------------------
echo 请选择要进行的操作（输入对应的数字，回车即可）
echo.
echo 1.禁ping
echo.
echo 2.放行端口
echo.
echo 3.禁止端口
echo.
echo 4.关闭防火墙
echo.
echo 5.退出
echo.
echo ------------------------------------------
set /p choi=请输入您的选择：

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
echo 禁ping了
echo.
pause
goto :Win7AndLater
::============================================================
:Allowport
cls
call :ENABLEFW
echo 默认都是放行tcp协议的端口，支持范围输入比如80-90，可以放行80-90的所有端口
set /p port=请输入要放行的端口号：
netsh advfirewall firewall delete rule name="放行TCP%port%"
netsh advfirewall firewall add rule name="放行TCP%port%" protocol=TCP localport=%port% dir=in action=allow
cls
echo.
echo 放行TCP%port%端口了
echo.
pause
goto :Win7AndLater
::============================================================
:DenyPort
cls
call :ENABLEFW
echo 默认都是禁止tcp协议的端口，支持范围输入比如80-90，可以放行80-90的所有端口
set /p port=请输入要禁止的端口号：
netsh advfirewall firewall delete rule name="禁止TCP%port%"
netsh advfirewall firewall add rule name="禁止TCP%port%" protocol=TCP localport=%port% dir=in action=block
cls
echo.
echo 禁止TCP%port%端口了
echo.
pause
goto :Win7AndLater
::============================================================
:CloseFW
cls
netsh advfirewall set currentprofile state off
cls
echo.
echo 关闭防火墙了
echo.
pause
goto :Win7AndLater
::============================================================
::启用防火墙
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
echo 当前远程端口是%RDport%
echo.
echo 当前系统是!_OSarch!系统
echo.
echo 当前系统版本是!_WinBuild!
echo.
echo ------------------------------------------
echo 请选择要进行的操作（输入对应的数字，回车即可）
echo.
echo 1.禁ping
echo.
echo 2.放行端口
echo.
echo 3.禁止端口
echo.
echo 4.关闭防火墙
echo.
echo 5.退出
echo.
echo ------------------------------------------
set /p chois=请输入您的选择：

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
echo 禁ping设置完成
echo.
pause
goto :VistaAndBelow
::============================================================
:Allowportb
cls
set /p port=请输入要放行的端口号（默认都是放行tcp协议的端口）：
call :ENABLEFWb
netsh firewall add portopening tcp %port% 放行TCP%port%端口
cls
echo.
echo 放行TCP%port%端口了
echo.
pause
goto :VistaAndBelow
::============================================================
:DenyPortb
cls
set /p port=请输入要禁止的端口号（默认都是禁止tcp协议的端口）：
call :ENABLEFWb
netsh firewall delete portopening tcp %port%
cls
echo.
echo 禁止TCP%port%端口了
echo.
pause
goto :VistaAndBelow
::============================================================
:CloseFWb
cls
netsh firewall set opmode mode = disable
cls
echo.
echo 关闭防火墙了
echo.
pause
goto :VistaAndBelow
::============================================================
::启用防火墙
:ENABLEFWb
netsh firewall set opmode mode = enable
netsh firewall set service remotedesktop enable
netsh firewall set portopening tcp %RDport% enable
exit /b
::============================================================
