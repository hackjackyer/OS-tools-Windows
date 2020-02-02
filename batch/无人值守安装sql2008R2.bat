@echo off
::by hackjackyer
setlocal enabledelayedexpansion
mode con cols=80 lines=20& color 2f
title 数据库2008R2自动安装器-请不要关闭此窗口！！！

::=============================================================
::生成随机密码
::设置密码长度为10位
set snow=10
for %%1 in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
::因为系统要求密码强度比较高，所以，在随机的基础上，加上固定的几个字符
set m=A@b1!m!

::=============================================================
::判断.net3.5是否安装了。
if not exist "%windir%\Microsoft.NET\Framework\v3.5" (
	echo 请先安装.net3.5，安装后重新运行此程序!
	pause
	exit
)


if not exist "setup.exe" (
        echo 错误:没有发现 MSSQL 安装文件,请确认批处理与setup.exe位于同一目录
        pause
        exit
)


:install_sql
Setup.exe ^
/QS /ACTION=Install ^
/IACCEPTSQLSERVERLICENSETERMS ^
/FEATURES=SQL,Tools ^
/INSTANCENAME=MSSQLSERVER ^
/INDICATEPROGRESS ^
/AGTSVCACCOUNT="NT AUTHORITY\SYSTEM" ^
/AGTSVCSTARTUPTYPE="Automatic" ^
/SQLSVCSTARTUPTYPE="Automatic" ^
/SECURITYMODE="SQL" ^
/SAPWD="!m!" ^
/SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" ^
/SQLSYSADMINACCOUNTS="%username%"
::=============================================================
::创建快捷方式到桌面,账号密码（分2008系统，和2003系统，因为两个系统数据库安装后，快捷方式所在目录不一样）
if exist "%windir:~0,3%programdata" (
copy "%windir:~0,3%ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2008 R2\SQL Server Management Studio.lnk" "%userprofile%\desktop"
echo 数据库>"%userprofile%\desktop\数据库密码.txt"
echo 账号sa>>"%userprofile%\desktop\数据库密码.txt"
echo 密码!m!>>"%userprofile%\desktop\数据库密码.txt"
) Else (
copy "%allusersprofile%\「开始」菜单\程序\Microsoft SQL Server 2008 R2\SQL Server Management Studio.lnk" "%userprofile%\桌面"
echo 数据库>"%userprofile%\桌面\数据库密码.txt"
echo 账号sa>>"%userprofile%\桌面\数据库密码.txt"
echo 密码!m!>>"%userprofile%\桌面\数据库密码.txt"
)

title 安装完成，现在可以关闭这个批处理窗口了。
echo 安装完成
echo 数据库账号密码已放桌面：数据库密码文件里。
pause
