@echo off
::by hackjackyer
setlocal enabledelayedexpansion
mode con cols=80 lines=20& color 2f
title ���ݿ�2008R2�Զ���װ��-�벻Ҫ�رմ˴��ڣ�����

::=============================================================
::�����������
::�������볤��Ϊ10λ
set snow=10
for %%1 in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
::��ΪϵͳҪ������ǿ�ȱȽϸߣ����ԣ�������Ļ����ϣ����Ϲ̶��ļ����ַ�
set m=A@b1!m!

::=============================================================
::�ж�.net3.5�Ƿ�װ�ˡ�
if not exist "%windir%\Microsoft.NET\Framework\v3.5" (
	echo ���Ȱ�װ.net3.5����װ���������д˳���!
	pause
	exit
)


if not exist "setup.exe" (
        echo ����:û�з��� MSSQL ��װ�ļ�,��ȷ����������setup.exeλ��ͬһĿ¼
        pause
        exit
)


:install_sql
Setup.exe ^
/QS /ACTION=Install ^
/IACCEPTSQLSERVERLICENSETERMS ^
/FEATURES=SQL,Tools ^
/INSTANCENAME=MSSQLSERVER ^
/INDICATEPROGRESS ^
/AGTSVCACCOUNT="NT AUTHORITY\SYSTEM" ^
/AGTSVCSTARTUPTYPE="Automatic" ^
/SQLSVCSTARTUPTYPE="Automatic" ^
/SECURITYMODE="SQL" ^
/SAPWD="!m!" ^
/SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" ^
/SQLSYSADMINACCOUNTS="%username%"
::=============================================================
::������ݷ�ʽ������,�˺����루��2008ϵͳ����2003ϵͳ����Ϊ����ϵͳ���ݿⰲװ�󣬿�ݷ�ʽ����Ŀ¼��һ����
if exist "%windir:~0,3%programdata" (
copy "%windir:~0,3%ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2008 R2\SQL Server Management Studio.lnk" "%userprofile%\desktop"
echo ���ݿ�>"%userprofile%\desktop\���ݿ�����.txt"
echo �˺�sa>>"%userprofile%\desktop\���ݿ�����.txt"
echo ����!m!>>"%userprofile%\desktop\���ݿ�����.txt"
) Else (
copy "%allusersprofile%\����ʼ���˵�\����\Microsoft SQL Server 2008 R2\SQL Server Management Studio.lnk" "%userprofile%\����"
echo ���ݿ�>"%userprofile%\����\���ݿ�����.txt"
echo �˺�sa>>"%userprofile%\����\���ݿ�����.txt"
echo ����!m!>>"%userprofile%\����\���ݿ�����.txt"
)

title ��װ��ɣ����ڿ��Թر�������������ˡ�
echo ��װ���
echo ���ݿ��˺������ѷ����棺���ݿ������ļ��
pause
