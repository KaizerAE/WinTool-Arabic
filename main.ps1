# WinTool-Arabic - سكريبت رئيسي
# مشروع تحسين وتعديل نظام ويندوز للعرب

# التحقق من صلاحيات المسؤول
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "يجب تشغيل السكريبت بصلاحيات المسؤول!"
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# العنوان
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   WinTool-Arabic - أداة تحسين ويندوز   " -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# القائمة الرئيسية
function Show-Menu {
    Write-Host "اختر العملية المطلوبة:" -ForegroundColor Green
    Write-Host "1. تثبيت البرامج"
    Write-Host "2. تطبيق التعديلات والتحسينات"
    Write-Host "3. تنظيف النظام"
    Write-Host "4. خروج"
    Write-Host ""
}

# الحلقة الرئيسية
do {
    Show-Menu
    $choice = Read-Host "أدخل رقم الخيار"
    
    switch ($choice) {
        '1' {
            Write-Host "بدء تثبيت البرامج..." -ForegroundColor Yellow
            . ".\modules\install.ps1"
            Install-Programs
        }
        '2' {
            Write-Host "بدء تطبيق التعديلات..." -ForegroundColor Yellow
            . ".\modules\tweaks.ps1"
            Apply-Tweaks
        }
        '3' {
            Write-Host "بدء تنظيف النظام..." -ForegroundColor Yellow
            . ".\modules\cleanup.ps1"
            Start-Cleanup
        }
        '4' {
            Write-Host "شكرا لاستخدامك WinTool-Arabic!" -ForegroundColor Green
            exit
        }
        default {
            Write-Host "خيار غير صحيح. حاول مرة أخرى." -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "اضِغط أي زر للمتابعة..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Clear-Host
} while ($true)
