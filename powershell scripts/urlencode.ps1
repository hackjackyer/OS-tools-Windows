# encode or decode url simple
Add-Type -AssemblyName system.web
while (0 -le 1) {
    $URL = Read-Host "Enter URL to Encode"
    $Encode = [System.Web.HttpUtility]::UrlEncode($URL)
    Start-Sleep 3
    Write-Host "This is the Encoded URL" $Encode -ForegroundColor Green

    $URL = Read-Host "Enter URL to Decode"
    $Decode = [System.Web.HttpUtility]::UrlDecode($URL)
    Start-Sleep 3
    Write-Host "This is the Encoded URL" $Decode -ForegroundColor Green
}
