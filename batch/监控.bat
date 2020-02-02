@shift
@echo oFF
set tcopu=%%bh%%jkq%%vz%%f7%%4c50t%%u1w8%%(cdf9)%%@6tc%%
%bh%jkq%vz%f7%4c50t%u1w8%(cdf9)%@6tc%
%tcopu:~32,1%shift
:1
%tcopu:~32,1%shift
%tcopu:~32,1%echo off
setlocal
MODE con: COLS=37 lines=3
color 0d
title  爆破监听程序  
for /L %%a in (
10,-1,0
) do (
echo     每隔10秒自动检测
echo     还剩余 %%a 秒
echo   {开发研究 } 勿关闭
ping -n 2 localhost 1>nul 2>nul
cls
)
::监控执行命令
goto :1
