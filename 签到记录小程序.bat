@echo off
rem ��ȡ��ǰ�������
set diannao=%computername%
color 2f
mode con cols=50 lines=20
title ��άǩ����¼-����%diannao%

:kaishi
cls
rem ��ȡ��ǰʱ�䣬��Ϊ�ļ�������Ϊ�ļ�����������/�ַ������ԣ�Ҫ��������һ�¡�
set shijian=%date:~,4%��%date:~5,2%��%date:~8,2%��%time:~,2%ʱ%time:~3,2%��%time:~6,2%��
set filename=%diannao%-%shijian%

::============================
if exist d:\��άǩ����¼ (pushd d:\��άǩ����¼) else (mkdir d:\��άǩ����¼)
pushd d:\��άǩ����¼

::============================
:xingming
echo.
set /p name1=������������ִ��ţ���A����
rem /i�������Դ�Сд��
if /i %name1% == a set name=����
if /i %name1% == b set name=����

rem �ж��Ƿ�����������ַ�������ж������������ַ���û�а��չ涨����ָ����Χ�ڵ��ַ���������������ģ��᷵��:xingming��
echo %name% |findstr /i "echo" >nul 2>nul&& (cls &echo ������������������ &goto :xingming)


::============================
cls
:shouhou
echo.
echo 1.�ۺ����1��
echo 2.�ۺ����2��
echo 3.�ۺ����3��
echo.
set /p shouhouQQ=���������½���ۺ�QQ������1-3�����֣���
if %shouhouqq% == 1 set qq1=�ۺ����1��
if %shouhouqq% == 2 set qq1=�ۺ����2��
if %shouhouqq% == 3 set qq1=�ۺ����3��

rem ͬ���������Ĳ���1-3���������ַ�����Ҫ���������롣ֱ������ָ����Χ�ַ���
echo %qq1% |findstr /i "echo" >nul 2>nul&& (cls &echo ������������������ &goto :shouhou)

::============================
cls
:yingxiao
echo.
echo 1.δ��¼Ӫ��
echo 2.Ӫ��1002��
echo 3.Ӫ��1003��
echo.
set /p yingxiaoQQ=���������½��Ӫ��QQ�ţ�����1-3�����֣���
if %yingxiaoqq% == 1 set qq2=δ��½Ӫ��QQ
if %yingxiaoqq% == 2 set qq2=Ӫ��1002��
if %yingxiaoqq% == 3 set qq2=Ӫ��1003��


echo %qq2% |findstr /i "echo" >nul 2>nul&& (cls &echo ������������������ &goto :yingxiao)

::============================
cls
:queren
echo.
echo.��ȷ��ǩ����Ϣ��
echo.
echo Ա����%name%
echo ��½���ۺ�QQ��%qq1%
echo ��½��Ӫ��QQ��%qq2%
echo.
set /p qian=�Ƿ���ȷ������Y,N����
if /i %qian% == y set qr=������
if /i %qian% == n goto :kaishi


echo %qr% |findstr /i "echo" >nul 2>nul&& (cls &echo ������������������ &goto :queren)


::============================
rem ǩ����Ϣ������ļ�
echo %shijian%>%filename%.txt
echo %name%>>%filename%.txt
echo %qq1%>>%filename%.txt
echo %qq2%>>%filename%.txt
echo.>>%filename%.txt

::============================
rem ����ftp��������Ϣ��
echo open 192.168.18.41>ftp.up
rem ����ǩ���ļ�Ҫ�ϴ��ķ�����IP
echo ftpuser>>ftp.up
echo ftppassword>ftp.up
echo cd qiandao>>ftp.up
echo put "%filename%.txt">>ftp.up
echo bye>>ftp.up
ftp -s:ftp.up>nul
rem ftp���øղŵ�ftp.up�ļ��������ϴ��ļ�
del %filename%.txt /q
del ftp.up /q

cls
echo.
echo ǩ���У��벻Ҫ�رմ˴��ڣ�
echo.
ping -n 4 127.0.0.1>nul 2>nul

cls
mshta vbscript:msgbox("%name% ��ǩ�����",64,"ǩ������")(window.close)
exit



