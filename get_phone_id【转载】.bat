@echo off
::转载，原文地址http://bbs.pcbeta.com/viewthread-1825560-1-2.html
setlocal enabledelayedexpansion
for /f "skip=1 tokens=3,* delims=: " %%i in ('cscript %windir%\system32\slmgr.vbs /dti') do set ID=%%i
for /f "delims=" %%a in ("%ID%") do (
        set c0=%%a
        set c1=!c0:~0,7!
        set c2=!c0:~7,7!
        set c3=!c0:~14,7!
        set c4=!c0:~21,7!
        set c5=!c0:~28,7!
        set c6=!c0:~35,7!
        set c7=!c0:~42,7!
        set c8=!c0:~49,7!
        set c9=!c0:~56,7!
        echo install ID:xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
        echo !c1!-!c2!-!c3!-!c4!-!c5!-!c6!-!c7!-!c8!-!c9!
        @echo !c1!-!c2!-!c3!-!c4!-!c5!-!c6!-!c7!-!c8!-!c9!>"%~dp0InsID.txt"
)
echo.
echo.Please view the document[InsID.txt]
pause
