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
title  ���Ƽ�������  
for /L %%a in (
10,-1,0
) do (
echo     ÿ��10���Զ����
echo     ��ʣ�� %%a ��
echo   {�����о� } ��ر�
ping -n 2 localhost 1>nul 2>nul
cls
)
::���ִ������
goto :1
