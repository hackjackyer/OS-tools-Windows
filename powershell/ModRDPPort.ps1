#Requires -RunAsAdministrator
<#
.SYNOPSIS
  修改 Windows RDP 端口 + 防火墙放行 + 提示重启
.NOTES
  必须以管理员身份运行 PowerShell
#>

# ============== 0. 检查管理员权限 ==============
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[错误] 请以管理员身份运行 PowerShell" -ForegroundColor Red
    Write-Host "  右键开始菜单 → 终端 (管理员)" -ForegroundColor Yellow
    pause
    exit
}

# ============== 1. 读取用户输入 ==============
do {
    $input = Read-Host "请输入新的 RDP 端口 (1024-65535)"
    $newPort = 0
    $valid = [int]::TryParse($input, [ref]$newPort)
    if ($valid -and $newPort -eq 3389) {
        Write-Host "[提示] 3389 是默认端口，无需修改" -ForegroundColor Yellow
        $valid = $false
    }
} while (-NOT $valid -or $newPort -lt 1024 -or $newPort -gt 65535)

# ============== 2. 备份当前端口 + 修改 ==============
$regPath = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
$oldPort = (Get-ItemProperty -Path $regPath -Name "PortNumber").PortNumber
Write-Host "[信息] 当前 RDP 端口: $oldPort" -ForegroundColor Cyan

# 确认
$confirm = Read-Host "确认改为 $newPort ? (y/n)"
if ($confirm -ne "y") { Write-Host "已取消" -ForegroundColor Yellow; exit }

# 修改注册表
Set-ItemProperty -Path $regPath -Name "PortNumber" -Value $newPort
Write-Host "[成功] 注册表已修改" -ForegroundColor Green

# 防火墙放行新端口
$ruleName = "RDP-Custom-$newPort"
New-NetFirewallRule -DisplayName $ruleName `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort $newPort `
    -Action Allow `
    -Profile Any `
    -ErrorAction SilentlyContinue
Write-Host "[成功] 防火墙规则已添加: $ruleName" -ForegroundColor Green

# 询问是否禁用默认 3389
$disableOld = Read-Host "是否禁用默认 3389 规则? (y/n) [推荐 y]"
if ($disableOld -eq "y") {
    Disable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -ErrorAction SilentlyContinue
    Write-Host "[成功] 默认 3389 规则已禁用" -ForegroundColor Yellow
}

# 重启 TermService（不重启系统，新端口立即生效）
Write-Host "[信息] 正在重启 TermService..." -ForegroundColor Cyan
Restart-Service TermService -Force
Write-Host "[成功] TermService 已重启" -ForegroundColor Green

# ============== 3. 提示重启 ==============
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " RDP 端口修改完成" -ForegroundColor Green
Write-Host "   旧端口: $oldPort" -ForegroundColor White
Write-Host "   新端口: $newPort" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  ⚠️  ⚠️  重要  ⚠️  ⚠️  ⚠️" -ForegroundColor Red
Write-Host "当前 RDP 连接会断开！请用新地址重连：" -ForegroundColor Red
Write-Host "  <本机IP>:$newPort" -ForegroundColor Yellow
Write-Host ""
Write-Host "TermService 已重启，新端口已生效。" -ForegroundColor Cyan
Write-Host "建议重启系统确保彻底生效。" -ForegroundColor Yellow
Write-Host ""
$restart = Read-Host "现在重启系统吗? (y/n)"
if ($restart -eq "y") {
    Write-Host "[信息] 30 秒后重启..." -ForegroundColor Cyan
    shutdown /r /t 30 /c "RDP 端口修改完成"
} else {
    Write-Host "[提示] 稍后手动重启: shutdown /r /t 0" -ForegroundColor Yellow
}
