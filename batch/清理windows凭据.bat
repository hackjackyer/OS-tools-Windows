@echo off
::hackjackyer
::���˾���Զ�̷�������ϰ���Ա������룬���浽windowsϵͳ���޾ͻᱨ��ƾ֤�洢������
chcp 65001
for /f "tokens=2 delims==" %%a in ('cmdkey /list^|findstr "Target"') do cmdkey /delete:%%a && echo %%a
echo "windowsƾ��ȫ���������"
ping -n 5 127.0.0.1>nul