# موديول تنظيف النظام
# System Cleanup Module

function Start-Cleanup {
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "   تنظيف وتحسين النظام   " -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "تحذير: سيتم حذف الملفات المؤقتة وغير الضرورية" -ForegroundColor Yellow
    $confirm = Read-Host "هل تريد المتابعة? (Y/N)"
    
    if ($confirm -ne 'Y' -and $confirm -ne 'y') {
        Write-Host "تم الغاء العملية." -ForegroundColor Yellow
        return
    }

    # تنظيف مجلد Temp
    Write-Host "تنظيف الملفات المؤقتة..." -ForegroundColor Yellow
    
    try {
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "تم تنظيف مجلد Temp المستخدم" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تنظيف بعض الملفات المؤقتة" -ForegroundColor Red
    }

    try {
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "تم تنظيف مجلد Temp النظام" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تنظيف بعض ملفات النظام المؤقتة" -ForegroundColor Red
    }

    # تنظيف سلة المحذوفات
    Write-Host "تنظيف سلة المحذوفات..." -ForegroundColor Yellow
    
    try {
        Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        Write-Host "تم تفريغ سلة المحذوفات" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تفريغ سلة المحذوفات" -ForegroundColor Red
    }

    # تنظيف Windows Update Cache
    Write-Host "تنظيف ملفات Windows Update..." -ForegroundColor Yellow
    
    try {
        Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Service -Name wuauserv -ErrorAction SilentlyContinue
        Write-Host "تم تنظيف ملفات Windows Update" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تنظيف Windows Update" -ForegroundColor Red
    }

    # تنظيف Prefetch
    Write-Host "تنظيف ملفات Prefetch..." -ForegroundColor Yellow
    
    try {
        Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
        Write-Host "تم تنظيف Prefetch" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تنظيف Prefetch" -ForegroundColor Red
    }

    # تشغيل Disk Cleanup
    Write-Host "تشغيل أداة Disk Cleanup..." -ForegroundColor Yellow
    
    try {
        Start-Process -FilePath CleanMgr.exe -ArgumentList "/sagerun:1" -Wait -ErrorAction SilentlyContinue
        Write-Host "تم تشغيل Disk Cleanup" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تشغيل Disk Cleanup" -ForegroundColor Red
    }

    # تحسين القرص (Optimize Drives)
    Write-Host "تحسين القرص..." -ForegroundColor Yellow
    
    try {
        Optimize-Volume -DriveLetter C -Defrag -ErrorAction SilentlyContinue
        Write-Host "تم تحسين القرص C" -ForegroundColor Green
    }
    catch {
        Write-Host "فشل تحسين القرص" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "تم الانتهاء من عملية التنظيف!" -ForegroundColor Green
    
    # عرض معلومات القرص
    Write-Host ""
    Write-Host "معلومات القرص:" -ForegroundColor Cyan
    Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Name -eq 'C' } | ForEach-Object {
        $freespace = [math]::Round($_.Free / 1GB, 2)
        $usedspace = [math]::Round($_.Used / 1GB, 2)
        $totalspace = [math]::Round(($_.Free + $_.Used) / 1GB, 2)
        Write-Host "المساحة الإجمالية: $totalspace GB" -ForegroundColor White
        Write-Host "المساحة المستخدمة: $usedspace GB" -ForegroundColor White
        Write-Host "المساحة الفارغة: $freespace GB" -ForegroundColor Green
    }
}
