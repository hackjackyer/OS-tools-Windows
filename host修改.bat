@echo off
echo **********************************
echo *如果杀毒软件提示，一定要选择允许*
echo **********************************
echo.
::备份文件到hosts.bak目录
@xcopy %systemroot%\system32\drivers\etc\hosts %systemroot%\system32\drivers\etc\hosts.bak\ /d /c /i /y>nul
echo hosts文件备份完毕，开始修改hosts文件
echo.
echo 格式如:
echo 192.168.18.100 www.baidu.com
echo.
set /p host_ip=请输入IP空格网址:
echo %host_ip%>"%systemroot%\system32\drivers\etc\hosts"
type "%systemroot%\system32\drivers\etc\hosts"
ping -n 2 127.0.0.1>nul
cls
echo 定向解析条目添加完成
ipconfig /flushdns>nul
echo 刷新了DNS缓存
ping -n 2 127.0.0.1>nul
::测试现在是否解析到了hosts文件所指向的IP
for /f "tokens=2 delims= " %%i in ('echo %host_ip%') do ping %%i -n 2

cls
echo 现在测试下（先不要关闭这个窗口）
ping -n 12 127.0.0.1>nul
echo 按任意键恢复原来的hosts文件
pause
copy %systemroot%\system32\drivers\etc\hosts.bak\hosts %systemroot%\system32\drivers\etc\hosts /y>nul
ipconfig /flushdns>nul
echo hosts文件恢复完成
ping -n 2 127.0.0.1>nul
exit
