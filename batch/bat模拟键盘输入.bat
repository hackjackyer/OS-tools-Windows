@echo off
more +3 %0|osql -E
exit
sp_password null,'abc123','sa
go
exit

::这样就可以模拟键盘输入来操作了。