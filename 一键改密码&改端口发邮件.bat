@echo off
::=======================================================================================
::���qq�����ַ
set qquser=
::���qq������Ȩ�룬��������Ŷ
set qqauth=
::�����ʼ���qq����
set revqq=
::��ӳ�������
set revqqcc=
::=======================================================================================
::�ж��ܷ�����
ping -n 2 www.baidu.com >nul 2>nul
if errorlevel 0 (
    goto online
) else (
    goto offline
)
::=======================================================================================

:offline
::=======================================================================================
call :changport
del һ�������룬�Ķ˿�.bat
exit
::=======================================================================================

::=======================================================================================
:online
::��ȡip
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr "IPv4 ��ַ"') do set ip=%%i
::��������˿ں�
call :changport
::�����������
setlocal enabledelayedexpansion
set snow=12
for %%i in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%i)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
set password=Qa1@!m!
::��������
net user %username% %password%
::���ʼ�
echo NameSpace = "http://schemas.microsoft.com/cdo/configuration/" >mail.vbs
echo Set Email = CreateObject("CDO.Message") >>mail.vbs
echo Email.From = "%qquser%" >>mail.vbs
echo Email.To = "%revqq%" >>mail.vbs
::echo Email.CC = "%revqqcc%" >>mail.vbs
echo Email.Subject = "%ip% �ʺ����룬Զ�̶˿�" >>mail.vbs
echo Email.HTMLbody = "������: %ip%:%port%<br>�ʺ�: %username%<br>����: %password%" >>mail.vbs
::echo Email.Textbody = "������%ip%:%port%    �ʺ�%username%   ����%password%" >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "sendusing") = 2 >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "smtpserver")= "smtp.qq.com" >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "smtpserverport")= 25 >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "smtpauthenticate") = 1 >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "sendusername")= "%qquser%" >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "sendpassword")= "%qqauth%" >>mail.vbs
echo Email.Configuration.Fields.Item(NameSpace ^& "smtpusessl")= 1 >>mail.vbs
echo Email.Configuration.Fields.Update >>mail.vbs
echo Email.Send >>mail.vbs
call mail.vbs
del mail.vbs
del һ�������룬�Ķ˿�.bat
exit
::=======================================================================================


::=======================================================================================
:changport
::�������Զ�̶˿�
set /a port=%random% + 1024
::�޸�Զ�̶˿�
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t reg_dword /d %port% /f
::����Զ�̶˿�
for /f "tokens=2 delims= " %%i in ('netsh advfirewall firewall show rule name^=all dir^=in ^|findstr "����Զ�̶˿�TCP"') do set tmprule=%%i
netsh advfirewall firewall delete rule name="%tmprule"
netsh advfirewall firewall add rule name="����Զ�̶˿�TCP%port%" protocol=TCP localport=%port% dir=in action=allow
::����Զ�̷���ʹ�¶˿���Ч
sc stop UmRdpService
sc stop TermService
sc stop SessionEnv
ping -n 10 127.0.0.1>nul
sc start TermService
sc start UmRdpService
sc start SessionEnv
exit /b
::=======================================================================================
