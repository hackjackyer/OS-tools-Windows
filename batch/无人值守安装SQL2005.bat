@echo off
::by hackjackyer
setlocal enabledelayedexpansion
mode con cols=80 lines=20& color 2f
title 数据库2005自动安装器-请不要关闭此窗口！！！

::=============================================================
::生成随机密码
::设置密码长度为10位
set snow=10
for %%1 in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
set m=A@b1!m!

::=============================================================
if not exist "setup.exe" (
        echo 错误:没有发现 MSSQL 安装文件,请确认批处理位于安装包根目录
        pause
        exit
)


:install_sql
echo [Options]>setup.ini
echo USERNAME=Microsoft>>setup.ini
echo COMPANYNAME=Microsoft>>setup.ini
echo ADDLOCAL=SQL_Engine,SQL_Tools90>>setup.ini
echo INSTANCENAME=MSSQLSERVER>>setup.ini
echo SECURITYMODE=SQL>>setup.ini
echo SAPWD=!m!>>setup.ini
echo SQLACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini
echo AGTACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini
echo SQLBROWSERACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini

start /wait setup.exe /settings "%cd%\setup.ini" /qb

::=============================================================
::创建快捷方式到桌面,账号密码
if exist "%windir:~0,3%programdata" (
copy "%windir:~0,3%ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2005\SQL Server Management Studio.lnk" "%userprofile%\desktop"
echo 数据库>"%userprofile%\desktop\数据库密码.txt"
echo 账号sa>>"%userprofile%\desktop\数据库密码.txt"
echo 密码!m!>>"%userprofile%\desktop\数据库密码.txt"
) Else (
copy "%allusersprofile%\「开始」菜单\程序\Microsoft SQL Server 2005\SQL Server Management Studio.lnk" "%userprofile%\桌面"
echo 数据库>"%userprofile%\桌面\数据库密码.txt"
echo 账号sa>>"%userprofile%\桌面\数据库密码.txt"
echo 密码!m!>>"%userprofile%\桌面\数据库密码.txt"
)

del "%cd%\setup.ini" /q
echo 安装完成
echo 数据库账号密码已放桌面：数据库密码文件里。
pause
exit


