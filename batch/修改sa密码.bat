@echo off
::===============================================================================================
::关闭密码复杂性
@echo [version]>xiaoyu.inf
@echo signature="$CHICAGO$">>xiaoyu.inf
@echo [System Access]>>xiaoyu.inf
@echo PasswordComplexity = 0 >>xiaoyu.inf
@secedit /configure /db xiaoyu.sdb /cfg xiaoyu.inf /log xiaoyu.log /quiet
@del xiaoyu.inf
@del xiaoyu.sdb
@del xiaoyu.log
::===============================================================================================
::判断数据库版本
for /f "tokens=3*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Setup" /v SQLPath') do set SQLreg="%%i %%j"
pushd %SQLreg%
cd ..
cd ..
set SQLroot=%cd%

::set SQL_2014="%SQLroot:~1,-15%\110\Tools\Binn\"
::set SQL_2016="%SQLroot:~1,-15%\110\Tools\Binn\"
set SQL_2012="%SQLroot%\110\Tools\Binn"
set SQL_2008="%SQLroot%\100\Tools\Binn"
set SQL_2005="%SQLroot%\90\Tools\Binn"

if exist %SQL_2012%\sqlcmd.exe set sqlcmd_files=%SQL_2012% &goto :xiugaimima
if exist %SQL_2008%\sqlcmd.exe set sqlcmd_files=%SQL_2008% &goto :xiugaimima
if exist %SQL_2005%\sqlcmd.exe set sqlcmd_files=%SQL_2005% &goto :xiugaimima

echo 没有找到数据库文件，请手动指定sqlcmd文件位置
echo 如路径有空格，请在路径两边加双引号，如"c:\Microsoft SQL Server"
set /p sqlcmd_files=数据库sqlcmd.exe文件所在目录的绝对路径：

::===============================================================================================
:xiugaimima
echo 密码如需要特殊字符，请不要使用引号，分号
set /p mima="请输入要修改为的sa密码："
pushd %sqlcmd_files%
echo sp_password null,'%mima%','sa'>%temp%xiaoyu.pwd
echo go>>%temp%xiaoyu.pwd
echo exit>>%temp%xiaoyu.pwd
more "%temp%xiaoyu.pwd"|sqlcmd -E
@del %temp%xiaoyu.pwd
cls
echo.
echo 修改完毕，sa密码是%mima%
echo.
pause
exit
