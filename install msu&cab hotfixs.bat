MSU
expand -F:* simple.msu c:\updates\
pushd c:\updates
dism /Online /Add-Package /PackagePath:c:\updates
or
dism /Online /Add-Package /PackagePath:c:\updates\simple.cab

CAB
dism /Online /Add-Package /PackagePath:d:\simple.cab
