install OS before input user and password
shift + F10 = cmd
robocopy "C:\Users" "D:\Users" /E /COPYALL /XJ
rmdir "C:\Users" /S /Q
mklink /J "C:\Users" "D:\Users"