@echo off
echo **********************************
echo *���ɱ�������ʾ��һ��Ҫѡ������*
echo **********************************
echo.
::�����ļ���hosts.bakĿ¼
@xcopy %systemroot%\system32\drivers\etc\hosts %systemroot%\system32\drivers\etc\hosts.bak\ /d /c /i /y>nul
echo hosts�ļ�������ϣ���ʼ�޸�hosts�ļ�
echo.
echo ��ʽ��:
echo 192.168.18.100 www.baidu.com
echo.
set /p host_ip=������IP�ո���ַ:
echo %host_ip%>"%systemroot%\system32\drivers\etc\hosts"
type "%systemroot%\system32\drivers\etc\hosts"
ping -n 2 127.0.0.1>nul
cls
echo ���������Ŀ������
ipconfig /flushdns>nul
echo ˢ����DNS����
ping -n 2 127.0.0.1>nul
::���������Ƿ��������hosts�ļ���ָ���IP
for /f "tokens=2 delims= " %%i in ('echo %host_ip%') do ping %%i -n 2

cls
echo ���ڲ����£��Ȳ�Ҫ�ر�������ڣ�
ping -n 12 127.0.0.1>nul
echo ��������ָ�ԭ����hosts�ļ�
pause
copy %systemroot%\system32\drivers\etc\hosts.bak\hosts %systemroot%\system32\drivers\etc\hosts /y>nul
ipconfig /flushdns>nul
echo hosts�ļ��ָ����
ping -n 2 127.0.0.1>nul
exit
