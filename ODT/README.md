# ODT Office Deploy Tools

## 命令

```bat
:: 下载安装文件
setup.exe /download configuration_down.xml

:: 安装office
setup.exe /configure configuration_install.xml
```

## 配置文件生成

* <https://config.office.com/deploymentsettings>

## 参考配置文件

微软官方提供了三个示例

* configuration-Office2019Enterprise.xml
* configuration-Office365-x64.xml
* configuration-Office365-x86.xml

## 自架设HTTP服务器，局域网安装

### 参考配置

```xml
<Configuration>
  <Add OfficeClientEdition="64" SourcePath="http://WEBSERVER/SHARE/"  Version="XXX.XX.XXX" ForceUpgrade="TRUE">
    <Product ID="ProPlusRetail">
      <Language ID="zh-cn" />
      <!--
  不想安装哪个就注释哪个
Access      Access
Excel       Excel
Lync        Skype for Business
OneDrive    OneDrive
OneNote     OneNote
Outlook     Outlook
PowerPoint  PowerPoint
Publisher   Publisher
Word        Word
 -->
      <ExcludeApp ID="Access" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="OneNote" />
      <ExcludeApp ID="Outlook" />
      <ExcludeApp ID="Publisher" />
    </Product>
  </Add>
  <Property Name="SharedComputerLicensing" Value="0" />
  <Property Name="PinIconsToTaskbar" Value="TRUE" />
  <Property Name="SCLCacheOverride" Value="0" />
  <Property Name="AUTOACTIVATE" Value="FALSE" />
  <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
  <Updates Enabled="TRUE" />
  <RemoveMSI>
    <IgnoreProduct ID="VisPro" />
    <IgnoreProduct ID="VisStd" />
  </RemoveMSI>
  <Display Level="Full" AcceptEULA="TRUE" />
  <Logging Level="Standard" Path="c:/" />
</Configuration>
```
