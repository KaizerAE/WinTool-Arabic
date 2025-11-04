# موديول التعديلات والتحسينات
# System Tweaks Module

function Apply-Tweaks {
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "   تعديلات وتحسينات النظام   " -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "تحذير: سيتم تعديل بعض إعدادات النظام" -ForegroundColor Yellow
    $confirm = Read-Host "هل تريد المتابعة? (Y/N)"
    
    if ($confirm -ne 'Y' -and $confirm -ne 'y') {
        Write-Host "تم الغاء العملية." -ForegroundColor Yellow
        return
    }

    # تعطيل Windows Defender (مؤقت)
    Write-Host "تعطيل Windows Defender مؤقتًا..." -ForegroundColor Yellow
    try {
        Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
        Write-Host "تم تعطيل Windows Defender" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تعطيل Windows Defender" -ForegroundColor Red
    }

    # تحسين أداء النظام
    Write-Host "تطبيق تحسينات الأداء..." -ForegroundColor Yellow
    
    # تعطيل التأثيرات المرئية
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -ErrorAction SilentlyContinue
    
    # تعطيل Cortana
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -ErrorAction SilentlyContinue
    
    # تعطيل البحت عبر الويب
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -ErrorAction SilentlyContinue
    
    # تعطيل التحديثات التلقائية للتطبيقات
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1 -ErrorAction SilentlyContinue
    
    # تحسين بدء التشغيل
    Write-Host "تحسين بدء التشغيل..." -ForegroundColor Yellow
    bcdedit /set bootmenupolicy standard
    
    # تعطيل تأثيرات الشفافية
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -ErrorAction SilentlyContinue
    
    # تعطيل Telemetry
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "تم تطبيق التعديلات بنجاح!" -ForegroundColor Green
    Write-Host "قد تحتاج لإعادة تشغيل الجهاز لتفعيل بعض التغييرات." -ForegroundColor Cyan
}
