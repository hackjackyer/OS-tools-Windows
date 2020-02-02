@echo off
::by hackjackyer
setlocal enabledelayedexpansion
mode con cols=80 lines=20& color 2f
::=========================取消密码复杂性
@echo [version]>xiaoyu.inf
@echo signature="$CHICAGO$">>xiaoyu.inf
@echo [System Access]>>xiaoyu.inf
@echo PasswordComplexity = 0 >>xiaoyu.inf
@secedit /configure /db xiaoyu.sdb /cfg xiaoyu.inf /log xiaoyu.log /quiet
@del xiaoyu.inf
@del xiaoyu.sdb
@del xiaoyu.log

::=========================查询数据库安装目录
for /f "tokens=3*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Setup" /v SQLPath') do set SQLreg="%%i %%j"
pushd %SQLreg%
cd ..
cd ..
set SQLroot=%cd%
set SQL_2012="%SQLroot%\110\Tools\Binn"
set SQL_2008="%SQLroot%\100\Tools\Binn"
set SQL_2005="%SQLroot%\90\Tools\Binn"
if exist %SQL_2012%\sqlcmd.exe set sqlcmd_files=%SQL_2012%&set SQLver=2012&goto :xiugaimima
if exist %SQL_2008%\sqlcmd.exe set sqlcmd_files=%SQL_2008%&set SQLver=2008 R2&goto :xiugaimima
if exist %SQL_2005%\sqlcmd.exe set sqlcmd_files=%SQL_2005%&set SQLver=2005&goto :xiugaimima
echo 没有找到数据库文件，请手动指定sqlcmd文件位置
echo 如路径有空格，请在路径两边加双引号，如"c:\Microsoft SQL Server"
set /p sqlcmd_files=数据库sqlcmd.exe文件所在目录的绝对路径：

::=========================随机生成密码
:xiugaimima
set snow=10
for %%1 in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
set mima=A@b1!m!

::=========================修改数据库密码
pushd %sqlcmd_files%
echo sp_password null,'!mima!','sa'>%temp%xiaoyu.pwd
echo go>>%temp%xiaoyu.pwd
echo exit>>%temp%xiaoyu.pwd
more "%temp%xiaoyu.pwd"|sqlcmd -E
@del %temp%xiaoyu.pwd
cls
echo.
echo 修改完毕，sa密码是!mima!，也生成在桌面上了。
echo.
echo 数据库>"%userprofile%\桌面\数据库密码.txt"
echo 账号sa>>"%userprofile%\桌面\数据库密码.txt"
echo 密码!mima!>>"%userprofile%\桌面\数据库密码.txt"
pause
exit
