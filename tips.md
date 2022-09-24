# TIPS

```powershell
# 查看恢复密钥ID
 manage-bde -protectors -get C:
 
# 设置windows UTC
New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation -Name RealTimeIsUniversal -PropertyType REG_QWORD -Value 1

# 下载最新版adb fastboot工具
https://dl.google.com/android/repository/platform-tools-latest-windows.zip
```
