@echo off
::by hackjackyer
setlocal enabledelayedexpansion
mode con cols=80 lines=20& color 2f
title ���ݿ�2005�Զ���װ��-�벻Ҫ�رմ˴��ڣ�����

::=============================================================
::�����������
::�������볤��Ϊ10λ
set snow=10
for %%1 in (2 3 4 5 6 7 8 9 a b c d e f g h i j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 63 +1
call set m=!m!%%x!n%%a!%%)
set m=A@b1!m!

::=============================================================
if not exist "setup.exe" (
        echo ����:û�з��� MSSQL ��װ�ļ�,��ȷ��������λ�ڰ�װ����Ŀ¼
        pause
        exit
)


:install_sql
echo [Options]>setup.ini
echo USERNAME=Microsoft>>setup.ini
echo COMPANYNAME=Microsoft>>setup.ini
echo ADDLOCAL=SQL_Engine,SQL_Tools90>>setup.ini
echo INSTANCENAME=MSSQLSERVER>>setup.ini
echo SECURITYMODE=SQL>>setup.ini
echo SAPWD=!m!>>setup.ini
echo SQLACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini
echo AGTACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini
echo SQLBROWSERACCOUNT=NT AUTHORITY\SYSTEM>>setup.ini

start /wait setup.exe /settings "%cd%\setup.ini" /qb

::=============================================================
::������ݷ�ʽ������,�˺�����
if exist "%windir:~0,3%programdata" (
copy "%windir:~0,3%ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2005\SQL Server Management Studio.lnk" "%userprofile%\desktop"
echo ���ݿ�>"%userprofile%\desktop\���ݿ�����.txt"
echo �˺�sa>>"%userprofile%\desktop\���ݿ�����.txt"
echo ����!m!>>"%userprofile%\desktop\���ݿ�����.txt"
) Else (
copy "%allusersprofile%\����ʼ���˵�\����\Microsoft SQL Server 2005\SQL Server Management Studio.lnk" "%userprofile%\����"
echo ���ݿ�>"%userprofile%\����\���ݿ�����.txt"
echo �˺�sa>>"%userprofile%\����\���ݿ�����.txt"
echo ����!m!>>"%userprofile%\����\���ݿ�����.txt"
)

del "%cd%\setup.ini" /q
echo ��װ���
echo ���ݿ��˺������ѷ����棺���ݿ������ļ��
pause
exit


