@echo off &setlocal enabledelayedexpansion
mode con cols=60 lines=10& color 0a& title 随机密码生成
::随机密码生成 by hackjackyer
echo.1.纯数字      2.数字英文    3.数字英文符号
set /p wind=选择序号:
echo. 
set /p snow=生成密码的长度:
echo.
set /p jizu=生成密码的个数：
echo 生成的密码>result.txt
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
set /p n=请输入n的值：
call set m=%%x!n!%%
echo !m!
goto :num
