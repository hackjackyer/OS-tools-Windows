@echo off
rem 获取当前计算机名
set diannao=%computername%
color 2f
mode con cols=50 lines=20
title 网维签到记录-电脑%diannao%

:kaishi
cls
rem 获取当前时间，作为文件名，因为文件名不允许有/字符，所以，要这样设置一下。
set shijian=%date:~,4%年%date:~5,2%月%date:~8,2%日%time:~,2%时%time:~3,2%分%time:~6,2%秒
set filename=%diannao%-%shijian%

::============================
if exist d:\网维签到记录 (pushd d:\网维签到记录) else (mkdir d:\网维签到记录)
pushd d:\网维签到记录

::============================
:xingming
echo.
set /p name1=请输入你的名字代号（如A）：
rem /i参数忽略大小写。
if /i %name1% == a set name=张三
if /i %name1% == b set name=李四

rem 判断是否输入上面的字符，如果有恶意输入其他字符的没有按照规定输入指定范围内的字符，或者输入有误的，会返回:xingming，
echo %name% |findstr /i "echo" >nul 2>nul&& (cls &echo 输入有误，请重新输入 &goto :xingming)


::============================
cls
:shouhou
echo.
echo 1.售后服务1号
echo 2.售后服务2号
echo 3.售后服务3号
echo.
set /p shouhouQQ=请输入你登陆的售后QQ（输入1-3的数字）：
if %shouhouqq% == 1 set qq1=售后服务1号
if %shouhouqq% == 2 set qq1=售后服务2号
if %shouhouqq% == 3 set qq1=售后服务3号

rem 同理，如果输入的不是1-3而是其他字符，会要求重新输入。直到输入指定范围字符。
echo %qq1% |findstr /i "echo" >nul 2>nul&& (cls &echo 输入有误，请重新输入 &goto :shouhou)

::============================
cls
:yingxiao
echo.
echo 1.未登录营销
echo 2.营销1002号
echo 3.营销1003号
echo.
set /p yingxiaoQQ=请输入你登陆的营销QQ号（输入1-3的数字）：
if %yingxiaoqq% == 1 set qq2=未登陆营销QQ
if %yingxiaoqq% == 2 set qq2=营销1002号
if %yingxiaoqq% == 3 set qq2=营销1003号


echo %qq2% |findstr /i "echo" >nul 2>nul&& (cls &echo 输入有误，请重新输入 &goto :yingxiao)

::============================
cls
:queren
echo.
echo.请确认签到信息！
echo.
echo 员工：%name%
echo 登陆的售后QQ：%qq1%
echo 登陆的营销QQ：%qq2%
echo.
set /p qian=是否正确（输入Y,N）：
if /i %qian% == y set qr=无语了
if /i %qian% == n goto :kaishi


echo %qr% |findstr /i "echo" >nul 2>nul&& (cls &echo 输入有误，请重新输入 &goto :queren)


::============================
rem 签到信息输出到文件
echo %shijian%>%filename%.txt
echo %name%>>%filename%.txt
echo %qq1%>>%filename%.txt
echo %qq2%>>%filename%.txt
echo.>>%filename%.txt

::============================
rem 设置ftp服务器信息。
echo open 192.168.18.41>ftp.up
rem 设置签到文件要上传的服务器IP
echo ftpuser>>ftp.up
echo ftppassword>ftp.up
echo cd qiandao>>ftp.up
echo put "%filename%.txt">>ftp.up
echo bye>>ftp.up
ftp -s:ftp.up>nul
rem ftp引用刚才的ftp.up文件来操作上传文件
del %filename%.txt /q
del ftp.up /q

cls
echo.
echo 签到中，请不要关闭此窗口！
echo.
ping -n 4 127.0.0.1>nul 2>nul

cls
mshta vbscript:msgbox("%name% 已签到完成",64,"签到程序")(window.close)
exit



