@echo off
::=======================================================================================
::你的qq邮箱地址
set qquser=
::你的qq邮箱授权码，不是密码哦
set qqauth=
::接受邮件的qq邮箱
set revqq=
::添加抄送邮箱
set revqqcc=
::=======================================================================================
::判断能否联网
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
del 一键改密码，改端口.bat
exit
::=======================================================================================

::=======================================================================================
:online
::获取ip
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr "IPv4 地址"') do set ip=%%i
::生成随机端口号
call :changport
::生成随机密码
setlocal enabledelayedexpansion
set snow=12
for %%i in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%i)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
set password=Qa1@!m!
::设置密码
net user %username% %password%
::发邮件
echo NameSpace = "http://schemas.microsoft.com/cdo/configuration/" >mail.vbs
echo Set Email = CreateObject("CDO.Message") >>mail.vbs
echo Email.From = "%qquser%" >>mail.vbs
echo Email.To = "%revqq%" >>mail.vbs
::echo Email.CC = "%revqqcc%" >>mail.vbs
echo Email.Subject = "%ip% 帐号密码，远程端口" >>mail.vbs
echo Email.HTMLbody = "服务器: %ip%:%port%<br>帐号: %username%<br>密码: %password%" >>mail.vbs
::echo Email.Textbody = "服务器%ip%:%port%    帐号%username%   密码%password%" >>mail.vbs
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
del 一键改密码，改端口.bat
exit
::=======================================================================================


::=======================================================================================
:changport
::随机生成远程端口
set /a port=%random% + 1024
::修改远程端口
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t reg_dword /d %port% /f
::放行远程端口
for /f "tokens=2 delims= " %%i in ('netsh advfirewall firewall show rule name^=all dir^=in ^|findstr "放行远程端口TCP"') do set tmprule=%%i
netsh advfirewall firewall delete rule name="%tmprule"
netsh advfirewall firewall add rule name="放行远程端口TCP%port%" protocol=TCP localport=%port% dir=in action=allow
::重启远程服务，使新端口生效
sc stop UmRdpService
sc stop TermService
sc stop SessionEnv
ping -n 10 127.0.0.1>nul
sc start TermService
sc start UmRdpService
sc start SessionEnv
exit /b
::=======================================================================================
