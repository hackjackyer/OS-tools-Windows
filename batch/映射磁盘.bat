@echo off
rem �������ӳ����Y�̣���ɾ��
net use Y /delete /y>nul
rem ������IP���ļ��У��˺�����
net use Y: \\IP\share password /user:user /persistent:yes>nul
echo �ɹ�����ӳ�����Y��
ping -n 2 127.0.0.1>nul
exit
