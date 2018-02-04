@echo off& setlocal enabledelayedexpansion
mode con cols=60 lines=10& color 0a& title .
del smile.txt 2>nul& echo.1.纯数字      2.数字英文    3.数字英文符号
set /p wind=选择序号:& echo. & set /p snow=输入生成组合个数:
for %%1 in (0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)do (set /a x+=1&& set x!x!=%%1)
if "%wind%"=="1" (for /l %%1 in (1 1 %snow%)do (for /l %%2 in (1 1 10)do (set /a n%%2=!random! %% 10
set m%%1=!m%%1!!n%%2!)
cls& echo %%1/%snow%& echo !m%%1!>>smile.txt))
if "%wind%"=="2" (for /l %%1 in (1 1 %snow%)do (for /l %%2 in (1 1 10)do (set /a n%%2=!random! %% 62 +1 
call set m%%1=!m%%1!%%x!n%%2!%%)
cls& echo %%1/%snow%& echo !m%%1!>>smile.txt))
if "%wind%"=="3" (more +14 "%~F0">smile.vbs& smile.vbs %snow%)
if exist smile.txt (start "" "smile.txt")else mshta vbscript:msgbox("输入错误")(close)
exit
x=array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","~","!","@","#","$","%","^","&","*","(",")","_","+","|","[","]","{","}",";","'",":",",",".","/","<",">","?")
for i = 1 to wscript.arguments(0)
for j = 1 to 10
Randomize
y=int(1000000*rnd mod 89)
n=n & x(y): next 
n=n & vbcrlf: next
createobject("scripting.filesystemobject").opentextfile("smile.txt",2,true).writeline n
