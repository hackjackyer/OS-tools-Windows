@echo off
::===============================================================================================
::�ر����븴����
@echo [version]>xiaoyu.inf
@echo signature="$CHICAGO$">>xiaoyu.inf
@echo [System Access]>>xiaoyu.inf
@echo PasswordComplexity = 0 >>xiaoyu.inf
@secedit /configure /db xiaoyu.sdb /cfg xiaoyu.inf /log xiaoyu.log /quiet
@del xiaoyu.inf
@del xiaoyu.sdb
@del xiaoyu.log
::===============================================================================================
::�ж����ݿ�汾
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

echo û���ҵ����ݿ��ļ������ֶ�ָ��sqlcmd�ļ�λ��
echo ��·���пո�����·�����߼�˫���ţ���"c:\Microsoft SQL Server"
set /p sqlcmd_files=���ݿ�sqlcmd.exe�ļ�����Ŀ¼�ľ���·����

::===============================================================================================
:xiugaimima
echo ��������Ҫ�����ַ����벻Ҫʹ�����ţ��ֺ�
set /p mima="������Ҫ�޸�Ϊ��sa���룺"
pushd %sqlcmd_files%
echo sp_password null,'%mima%','sa'>%temp%xiaoyu.pwd
echo go>>%temp%xiaoyu.pwd
echo exit>>%temp%xiaoyu.pwd
more "%temp%xiaoyu.pwd"|sqlcmd -E
@del %temp%xiaoyu.pwd
cls
echo.
echo �޸���ϣ�sa������%mima%
echo.
pause
exit
