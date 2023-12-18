# TIPS

```powershell
# 查看恢复密钥ID
 manage-bde -protectors -get C:
 
# 设置windows UTC
New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation -Name RealTimeIsUniversal -PropertyType REG_QWORD -Value 1

# 下载最新版adb fastboot工具
https://dl.google.com/android/repository/platform-tools-latest-windows.zip
```

## win7显示IE

```reg
Windows Registry Editor Version 5.00 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}] 
@="Internet Explorer" 
"InfoTip"="@C:\\WINDOWS\\system32\\zh-CN\\ieframe.dll.mui,-881" 
"LocalizedString"="@C:\\WINDOWS\\system32\\zh-CN\\ieframe.dll.mui,-880" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\DefaultIcon] 
@="C:\\Program Files\\Internet Explorer\\iexplore.exe,-32528" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell] 
@="" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\D] 
@="删除(D)" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\D\Command] 
@="Rundll32.exe" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\NoAddOns] 
@="在没有加载项的情况下启动" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\NoAddOns\Command] 
@="C:\\Program Files\\Internet Explorer\\iexplore.exe about:NoAdd-ons" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\Open] 
@="打开主页(H)" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\Open\Command] 
@="C:\\Program Files\\Internet Explorer\\iexplore.exe" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\属性(R)] 
@="" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\Shell\属性(R)\Command] 
@="Rundll32.exe Shell32.dll,Control_RunDLL Inetcpl.cpl" 
[HKEY_CLASSES_ROOT\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}\ShellFolder] 
@="" 
"Attributes"=dword:00000010 
"HideFolderVerbs"="" 
"WantsParseDisplayName"="" 
"HideOnDesktopPerUser"="" 
@="C:\\WINDOWS\\system32\\ieframe.dll,-190" 
"HideAsDeletePerUser"="" 
Windows Registry Editor Version 5.00 
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}] 
@="Internet Explorer" 
Windows Registry Editor Version 5.00 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}] 
@="Windows Media" 

```

## word删除汉字

```txt
按ctrl+F打开查找对话框，在查找框中输入[a-zA-Z]
勾选“使用通配符”和“突出显示所有在该范围找到的项目”两项。
单击“查找全部”按钮即可。 


只删除汉字，保留英文、标点的操作：
ctrl+H，查找内容：[一-﨩] ，替换为：不填为空。
高级>√使用通配符,全部替换就可以了。
删除汉字、标点，保留英文的操作：
ctrl+H，查找内容：[!^1-^127] ，替换为：不填为空。
高级>√使用通配符,全部替换就可以了。 

```

## 网络1，网络2.。。

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged
```
