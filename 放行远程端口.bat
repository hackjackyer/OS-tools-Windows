@echo off
title 2008以上版本系统，开启防火墙同时放行远程端口。
color 2f
setlocal enableDelayedExpansion
rem 获取远程端口号，因为获取的是16进制的值，所以用set /a参数，来换算成10进制。
for /f "tokens=3 delims= " %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" ^|find /i "PortNumber"') do set /a port=%%a
echo 当前远程端口是%port%
rem 配置防火墙服务自启动，并开启防火墙服务
sc config MpsSvc start= auto && sc start MpsSvc
rem 检查之前是否有做过放行规则，有则删除之前的，没有则，添加新规则
netsh advfirewall firewall show rule name=开启远程tcp>nul && call :deleterule || call :addrule

netsh advfirewall firewall add rule name=开启远程tcp dir=in action=allow protocol=TCP localport=%port%>nul
netsh advfirewall firewall add rule name=开启远程udp dir=in action=allow protocol=UDP localport=%port%>nul
:wancheng
echo 防火墙开启，并放行远程%port%端口了
pause
exit


:deleterule
echo 删除之前的规则
netsh advfirewall firewall delete rule name=开启远程tcp>nul
netsh advfirewall firewall delete rule name=开启远程udp>nul


:addrule
echo 加入新的规则
netsh advfirewall firewall add rule name=开启远程tcp dir=in action=allow protocol=TCP localport=%port%>nul
netsh advfirewall firewall add rule name=开启远程udp dir=in action=allow protocol=UDP localport=%port%>nul
goto :wancheng

