@echo off
echo 仅适用于2008 R2系统，2003系统需要微调。网关设置后面多一个auto参数
echo 有多个IP的，请在运行此批处理后，手动添加
echo 请输入主IP地址第三个点后的数字
echo （如192.168.1.1,只需输入76即可）
set /p ip=请输入:
netsh interface show interface "本地连接" |find "已连接" &&set ipname="本地连接" ||set ipname="本地连接 2"

netsh interface ip set address %ipname% static 192.168.1.%ip% 255.255.255.0 192.168.1.1
netsh interface ip del dns %ipname% del
netsh interface ip add dns %ipname% 8.8.8.8
netsh interface ip add dns %ipname% 114.114.114.114 index=2

netsh interface set interface %ipname% disabled
netsh interface set interface %ipname% enabled

netsh advfirewall firewall set rule name="远程桌面(TCP-In)" new enable=yes
cls
ping 103.71.48.%ip%
pause
