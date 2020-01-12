'cscript /nologo ics.vbs "无线网络连接" "本地连接" "off"
'将以上代码保存为*.bat文件运行，三个参数分别为，供别人连接的网卡名字、提供共享的网卡名称、开启(on)关闭(off)
' VBScript source code
OPTION EXPLICIT
DIM ICSSC_DEFAULT, CONNECTION_PUBLIC, CONNECTION_PRIVATE, CONNECTION_ALL
DIM NetSharingManager
DIM PublicConnection, PrivateConnection
DIM EveryConnectionCollection

DIM objArgs
DIM priv_con, publ_con
dim switch

ICSSC_DEFAULT         = 0
CONNECTION_PUBLIC     = 0
CONNECTION_PRIVATE    = 1
CONNECTION_ALL        = 2

Main()

sub Main( )
    Set objArgs = WScript.Arguments

    if objArgs.Count = 3 then
        priv_con = objArgs(0)'内网连接名
                publ_con = objArgs(1)'外网连接名
                switch = objArgs(2)'状态切换开关 on 为 打开ics  off 相反

        if Initialize() = TRUE then
            GetConnectionObjects()
            FirewallTestByName priv_con,publ_con
        end if
    else
        DIM szMsg
        if Initialize() = TRUE then
            GetConnectionObjects()
            FirewallTestByName "list","list"
        end if

        szMsg = "To share your internet connection, please provide the name of the private and public connections as the argument." & vbCRLF & vbCRLF & _
                "Usage:" & vbCRLF & _
                "       " & WScript.scriptname & " " & chr(34) & "Private Connection Name" & chr(34) & " " & chr(34) & "Public Connection Name" & chr(34)
        WScript.Echo( szMsg & vbCRLF & vbCRLF)
    end if
end sub

sub FirewallTestByName(con1,con2)
        on error resume next
    DIM Item
    DIM EveryConnection
    DIM objNCProps
    DIM szMsg
    DIM bFound1,bFound2

    WScript.echo(vbCRLF & vbCRLF)
    bFound1 = false
    bFound2 = false
    for each Item in EveryConnectionCollection
        set EveryConnection = NetSharingManager.INetSharingConfigurationForINetConnection(Item)
        set objNCProps = NetSharingManager.NetConnectionProps(Item)
        szMsg = "Name: "       & objNCProps.Name & vbCRLF & _
                "Guid: "       & objNCProps.Guid & vbCRLF & _
                "DeviceName: " & objNCProps.DeviceName & vbCRLF & _
                "Status: "     & objNCProps.Status & vbCRLF & _
                "MediaType: "  & objNCProps.MediaType
        if EveryConnection.SharingEnabled then
            szMsg = szMsg & vbCRLF & _
                    "SharingEnabled" & vbCRLF & _
                    "SharingType: " & ConvertConnectionTypeToString(EveryConnection.SharingConnectionType)
        end if

        if objNCProps.Name = con1 then
            bFound1 = true
            if EveryConnection.SharingEnabled = False and switch="on" then
                szMsg = szMsg & vbCRLF & "Not Shared... Enabling private connection share..."
                WScript.Echo(szMsg)
                EveryConnection.EnableSharing CONNECTION_PRIVATE
                szMsg = " Shared!"
                                                elseif(switch = "off") then 
                                                                szMsg = szMsg & vbCRLF & "Shared... DisEnabling private connection share..."
                WScript.Echo(szMsg)
                                                                EveryConnection.EnableSharing CONNECTION_ALL
                                
            end if
                        end if

        if objNCProps.Name = con2 then
            bFound2 = true
            if EveryConnection.SharingEnabled = False and switch="on" then
                szMsg = szMsg & vbCRLF & "Not Shared... Enabling public connection share..."
                WScript.Echo(szMsg)
                EveryConnection.EnableSharing CONNECTION_PUBLIC
                szMsg = " Shared!"
                                                elseif(switch = "off") then 
                                                                szMsg = szMsg & vbCRLF & "Shared... DisEnabling public connection share..."
                WScript.Echo(szMsg)
                                                                EveryConnection.EnableSharing CONNECTION_ALL
                   end if
        end if
        WScript.Echo(szMsg & vbCRLF & vbCRLF)
    next

    if( con1 <> "list" ) then
        if( bFound1 = false ) then
            WScript.Echo( "Connection " & chr(34) & con1 & chr(34) & " was not found" )
        end if
        if( bFound2 = false ) then
            WScript.Echo( "Connection " & chr(34) & con2 & chr(34) & " was not found" )
        end if
    end if
end sub

function Initialize()
    DIM bReturn
    bReturn = FALSE

    set NetSharingManager = Wscript.CreateObject("HNetCfg.HNetShare.1")
    if (IsObject(NetSharingManager)) = FALSE then
        Wscript.Echo("Unable to get the HNetCfg.HnetShare.1 object")
    else
        if (IsNull(NetSharingManager.SharingInstalled) = TRUE) then
            Wscript.Echo("Sharing isn't available on this platform.")
        else
            bReturn = TRUE
        end if
    end if
    Initialize = bReturn
end function

function GetConnectionObjects()
    DIM bReturn
    DIM Item

    bReturn = TRUE

    if GetConnection(CONNECTION_PUBLIC) = FALSE then
        bReturn = FALSE
    end if

    if GetConnection(CONNECTION_PRIVATE) = FALSE then
        bReturn = FALSE
    end if

    if GetConnection(CONNECTION_ALL) = FALSE then
        bReturn = FALSE
    end if

    GetConnectionObjects = bReturn

end function


function GetConnection(CONNECTION_TYPE)
    DIM bReturn
    DIM Connection
    DIM Item
    bReturn = TRUE

    if (CONNECTION_PUBLIC = CONNECTION_TYPE) then
        set Connection = NetSharingManager.EnumPublicConnections(ICSSC_DEFAULT)
        if (Connection.Count > 0) and (Connection.Count < 2) then
            for each Item in Connection
                set PublicConnection = NetSharingManager.INetSharingConfigurationForINetConnection(Item)
            next
        else
            bReturn = FALSE
        end if
    elseif (CONNECTION_PRIVATE = CONNECTION_TYPE) then
        set Connection = NetSharingManager.EnumPrivateConnections(ICSSC_DEFAULT)
        if (Connection.Count > 0) and (Connection.Count < 2) then
            for each Item in Connection
                set PrivateConnection = NetSharingManager.INetSharingConfigurationForINetConnection(Item)
            next
        else
            bReturn = FALSE
        end if
    elseif (CONNECTION_ALL = CONNECTION_TYPE) then
        set Connection = NetSharingManager.EnumEveryConnection
        if (Connection.Count > 0) then
            set EveryConnectionCollection = Connection
        else
            bReturn = FALSE
        end if
    else
        bReturn = FALSE
    end if

    if (TRUE = bReturn)  then
        if (Connection.Count = 0) then
            Wscript.Echo("No " + CStr(ConvertConnectionTypeToString(CONNECTION_TYPE)) + " connections exist (Connection.Count gave us 0)")
            bReturn = FALSE
        'valid to have more than 1 connection returned from EnumEveryConnection
        elseif (Connection.Count > 1) and (CONNECTION_ALL <> CONNECTION_TYPE) then
            Wscript.Echo("ERROR: There was more than one " + ConvertConnectionTypeToString(CONNECTION_TYPE) + " connection (" + CStr(Connection.Count) + ")")
            bReturn = FALSE
        end if
    end if
    Wscript.Echo(CStr(Connection.Count) + " objects for connection type " + ConvertConnectionTypeToString(CONNECTION_TYPE))

    GetConnection = bReturn
end function

function ConvertConnectionTypeToString(ConnectionID)
    DIM ConnectionString

    if (ConnectionID = CONNECTION_PUBLIC) then
        ConnectionString = "public"
    elseif (ConnectionID = CONNECTION_PRIVATE) then
        ConnectionString = "private"
    elseif (ConnectionID = CONNECTION_ALL) then
        ConnectionString = "all"
    else
        ConnectionString = "Unknown: " + CStr(ConnectionID)
    end if

    ConvertConnectionTypeToString = ConnectionString
end function