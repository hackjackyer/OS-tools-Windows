@echo off
pushd %~dp0
powershell.exe -command "& {set-executionpolicy Remotesigned -Scope Process; .'.\需要运行的脚本' }"
popd
pause