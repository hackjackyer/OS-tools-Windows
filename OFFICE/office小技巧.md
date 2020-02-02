# 1. office小技巧

<!-- TOC -->

- [1. office小技巧](#1-office%e5%b0%8f%e6%8a%80%e5%b7%a7)
  - [1.1. outlook批量导出联系人宏代码](#11-outlook%e6%89%b9%e9%87%8f%e5%af%bc%e5%87%ba%e8%81%94%e7%b3%bb%e4%ba%ba%e5%ae%8f%e4%bb%a3%e7%a0%81)
  - [1.2. word删除汉字](#12-word%e5%88%a0%e9%99%a4%e6%b1%89%e5%ad%97)
  - [1.3. 网络1，网络2.。。的删除](#13-%e7%bd%91%e7%bb%9c1%e7%bd%91%e7%bb%9c2%e7%9a%84%e5%88%a0%e9%99%a4)
  - [1.4. win7显示IE](#14-win7%e6%98%be%e7%a4%baie)

<!-- /TOC -->

## 1.1. outlook批量导出联系人宏代码

```vb
Sub vcf()
Dim MyContacts As Outlook.MAPIFolder
Dim ContItem As Outlook.ContactItem
Dim FileName As String
Set MyContacts = Application.GetNamespace("MAPI").GetDefaultFolder(olFolderContacts)
For Each ContItem In MyContacts.Items
FileName = "F:\vcf\1\" & ContItem.FileAs & ".vcf"
ContItem.SaveAs FileName, olVCard
Next
End Sub
```

## 1.2. word删除汉字

```word
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

## 1.3. 网络1，网络2.。。的删除

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged
```

## 1.4. win7显示IE

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
