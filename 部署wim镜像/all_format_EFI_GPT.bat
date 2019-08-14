@echo off
title 格式化F盘，部署install.wim的第1个索引的镜像
echo =======================================
echo =硬盘插进来了吗，先用HD PRO看下健康状态。=
echo =系统盘符修改的话，记得修改format.exe文件哦。要不激活错了分区，引导不了=
echo =本文不能直接拿来用，虽然已经很多可以使用的了，自己要修改适合自己的环境=
echo =======================================
pause
::自定义分区
diskpart /s tools\format_gpt.txt

::部署镜像
dism /apply-image /imagefile:wims\install.wim /index:1 /applydir:C:\

::设置引导
bcdboot C:\windows /s D: /l zh-cn /f ALL

::复制常用工具，安装包到系统盘
xcopy tools\ C:\tools\ /E /F

::安装主板,显卡,网卡,打印机等驱动，可以在安装好的主机上，输入dism /online /Export-Driver /Destination:C:\destpath,把所需的驱动都导出。放在drivers文件夹。
dism /image:C:\ /add-driver /driver:drivers\ /recurse /forceunsigned

::安装补丁
dism /image:C:\ /add-package /packagePath:hotfixs\

::设置自动化,可以去http://www.windowsafg.com这里，生成一个适用于自己的应答文件。
dism /image:C: /apply-unattend:unattend\unattend-8.1.xml

REM 其他三个方法有待验证。
REM 方法1
REM MkDir F:\Windows\Panther
REM Copy D:\buildOS\unattend\unattend-8.1.xml F:\Windows\Panther\unattend.xml
REM 方法2
REM dism /image:F: /apply-unattend:D:\buildOS\unattend\unattend-8.1.xml
REM 方法3
REM dism /image:F: /apply-unattend /apply-unattend:D:\buildOS\unattend\unattend-8.1.xml

::部署后，播放音乐
"Let Her Go - Jasmine Thompson.mp3"