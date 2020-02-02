@echo off
::hackjackyer
::有人经常远程服务器，习惯性保存密码，保存到windows系统上限就会报错。凭证存储已满。
chcp 65001
for /f "tokens=2 delims==" %%a in ('cmdkey /list^|findstr "Target"') do cmdkey /delete:%%a && echo %%a
echo "windows凭据全部清理完毕"
ping -n 5 127.0.0.1>nul