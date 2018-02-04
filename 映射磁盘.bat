@echo off
rem Èç¹û´æÔÚÓ³ÉäÅÌYÅÌ£¬ÔòÉ¾³ý
net use Y /delete /y>nul
rem ¹²ÏíÅÌIP£¬ÎÄ¼þ¼Ð£¬ÕËºÅÃÜÂë
net use Y: \\IP\share password /user:user /persistent:yes>nul
echo ³É¹¦´´½¨Ó³Éä´ÅÅÌYÅÌ
ping -n 2 127.0.0.1>nul
exit
