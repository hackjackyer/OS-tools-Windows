@echo off &setlocal enabledelayedexpansion
mode con cols=60 lines=10& color 0a& title �����������
::����������� by hackjackyer
echo.1.������      2.����Ӣ��    3.����Ӣ�ķ���
set /p wind=ѡ�����:
echo. 
set /p snow=��������ĳ���:
echo.
set /p jizu=��������ĸ�����
echo ���ɵ�����>result.txt
for %%1 in (0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z @ # $ ^( ^) / \) do (set /a x+=1&& set x!x!=%%1)
if "%wind%" == "1" (for /l %%b in (1 1 %jizu%)do (for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 10 +1
call set m%%b=!m%%b!%%x!n%%a!%%)
echo !m%%b!>>result.txt)
notepad result.txt)

if "%wind%" == "2" (for /l %%b in (1 1 %jizu%)do (for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 62 +1
call set m%%b=!m%%b!%%x!n%%a!%%)
echo !m%%b!>>result.txt)
notepad result.txt)

if "%wind%" == "3" (for /l %%b in (1 1 %jizu%)do (for /l %%a in (1 1 %snow%)do (set /a n%%a=!random! %% 69 +1
call set m%%b=!m%%b!%%x!n%%a!%%)
echo !m%%b!>>result.txt)
notepad result.txt)

if "%wind%" == "4" (goto :num)
exit

:num
set /p n=������n��ֵ��
call set m=%%x!n!%%
echo !m!
goto :num
