@echo off
title 2008���ϰ汾ϵͳ����������ǽͬʱ����Զ�̶˿ڡ�
color 2f
setlocal enableDelayedExpansion
rem ��ȡԶ�̶˿ںţ���Ϊ��ȡ����16���Ƶ�ֵ��������set /a�������������10���ơ�
for /f "tokens=3 delims= " %%a in ('REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" ^|find /i "PortNumber"') do set /a port=%%a
echo ��ǰԶ�̶˿���%port%
rem ���÷���ǽ����������������������ǽ����
sc config MpsSvc start= auto && sc start MpsSvc
rem ���֮ǰ�Ƿ����������й�������ɾ��֮ǰ�ģ�û��������¹���
netsh advfirewall firewall show rule name=����Զ��tcp>nul && call :deleterule || call :addrule

netsh advfirewall firewall add rule name=����Զ��tcp dir=in action=allow protocol=TCP localport=%port%>nul
netsh advfirewall firewall add rule name=����Զ��udp dir=in action=allow protocol=UDP localport=%port%>nul
:wancheng
echo ����ǽ������������Զ��%port%�˿���
pause
exit


:deleterule
echo ɾ��֮ǰ�Ĺ���
netsh advfirewall firewall delete rule name=����Զ��tcp>nul
netsh advfirewall firewall delete rule name=����Զ��udp>nul


:addrule
echo �����µĹ���
netsh advfirewall firewall add rule name=����Զ��tcp dir=in action=allow protocol=TCP localport=%port%>nul
netsh advfirewall firewall add rule name=����Զ��udp dir=in action=allow protocol=UDP localport=%port%>nul
goto :wancheng

