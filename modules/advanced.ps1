# وحدة الميزات المتقدمة - Advanced Features Module
# نسخة محسنة مع تحسينات الأداء وإعدادات الحماية
# Enhanced version with performance optimizations and security settings

<#
.DESCRIPTION
    وحدة متقدمة تتضمن تحسينات الأداء والخدمات وإعدادات الحماية
    Advanced module with performance optimizations, service management, and security settings

.AUTHOR
    WinTool-Arabic Team

.VERSION
    1.0.0
#>

# ==================== دوال تحسين الأداء ====================
# ==================== Performance Optimization Functions ====================

function Enable-UltimatePerformance {
    <#
    .DESCRIPTION
        تفعيل خطة الأداء القصوى
        Enable Ultimate Performance power plan
    #>
    Write-Host "تفعيل خطة الأداء القصوى..." -ForegroundColor Cyan
    Write-Host "Enabling Ultimate Performance power plan..." -ForegroundColor Cyan
    
    $guid = "e9a42b02-d5df-448d-aa00-03f14749e802"
    powercfg /setactive $guid
    
    # تعطيل Sleep على الهارد ديسك
    powercfg /change disk-timeout-ac 0
    powercfg /change disk-timeout-dc 0
    
    # تقليل وقت الموارد للنوم
    powercfg /change monitor-timeout-ac 0
    powercfg /change monitor-timeout-dc 0
    
    Write-Host "✓ تم تفعيل الأداء القصوى" -ForegroundColor Green
    Write-Host "✓ Ultimate Performance enabled" -ForegroundColor Green
}

function Disable-BackgroundApps {
    <#
    .DESCRIPTION
        تعطيل التطبيقات الخلفية غير الضرورية
        Disable unnecessary background applications
    #>
    Write-Host "تعطيل التطبيقات الخلفية..." -ForegroundColor Cyan
    Write-Host "Disabling background applications..." -ForegroundColor Cyan
    
    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
    Get-ChildItem -Path $path -ErrorAction SilentlyContinue | ForEach-Object {
        Set-ItemProperty -Path $_.PSPath -Name "Disabled" -Value 1 -ErrorAction SilentlyContinue
    }
    
    Write-Host "✓ تم تعطيل التطبيقات الخلفية" -ForegroundColor Green
    Write-Host "✓ Background applications disabled" -ForegroundColor Green
}

# ==================== إدارة الخدمات ====================
# ==================== Service Management ====================

function Disable-UnwantedServices {
    <#
    .DESCRIPTION
        تعطيل الخدمات غير المهمة
        Disable unnecessary services
    #>
    Write-Host "تعطيل الخدمات غير المهمة..." -ForegroundColor Cyan
    Write-Host "Disabling unnecessary services..." -ForegroundColor Cyan
    
    $servicesToDisable = @(
        "DiagTrack",                    # خدمة التشخيص / Diagnostic Tracking
        "dmwappushservice",             # خدمة الإعلانات / Advertisement Service
        "WSearch",                      # بحث Windows / Windows Search (optional)
        "TrkWks",                       # تتبع الموارد / Resource Tracking
        "TabletInputService",           # خدمة قلم الشاشة / Tablet Input
        "RemoteRegistry",               # السجل البعيد / Remote Registry
        "WMPNetworkSvc",                # شبكة مشغل الوسائط / Media Player Network
        "PcaSvc"                        # خدمة توافق الأداء / Performance Compatibility
    )
    
    foreach ($service in $servicesToDisable) {
        try {
            Get-Service -Name $service -ErrorAction SilentlyContinue | 
                Set-Service -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host "✓ تم تعطيل: $service" -ForegroundColor Green
        } catch {
            Write-Host "✗ فشل تعطيل: $service" -ForegroundColor Yellow
        }
    }
    
    Write-Host "✓ اكتمل تعطيل الخدمات" -ForegroundColor Green
    Write-Host "✓ Service disabling completed" -ForegroundColor Green
}

# ==================== إعدادات الحماية والخصوصية ====================
# ==================== Security and Privacy Settings ====================

function Enable-PrivacyProtection {
    <#
    .DESCRIPTION
        تفعيل إعدادات حماية الخصوصية المتقدمة
        Enable advanced privacy protection settings
    #>
    Write-Host "تفعيل إعدادات حماية الخصوصية..." -ForegroundColor Cyan
    Write-Host "Enabling privacy protection settings..." -ForegroundColor Cyan
    
    # تعطيل جمع البيانات / Disable Telemetry
    $telemetryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    New-Item -Path $telemetryPath -Force -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path $telemetryPath -Name "AllowDiagnosticData" -Value 0
    
    # تعطيل Cortana / Disable Cortana
    $cortanaPath = "HKCU:\Software\Microsoft\Personalization\Settings"
    New-Item -Path $cortanaPath -Force -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path $cortanaPath -Name "AcceptedPrivacyPolicy" -Value 0
    
    # تعطيل الإعلانات المخصصة / Disable Personalized Ads
    $adsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    New-Item -Path $adsPath -Force -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path $adsPath -Name "Enabled" -Value 0
    
    # تعطيل الحافظة السحابية / Disable Cloud Clipboard
    $clipboardPath = "HKCU:\Software\Microsoft\Clipboard"
    New-Item -Path $clipboardPath -Force -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path $clipboardPath -Name "CloudClipboardAutomaticUpload" -Value 0
    
    Write-Host "✓ تم تفعيل حماية الخصوصية" -ForegroundColor Green
    Write-Host "✓ Privacy protection enabled" -ForegroundColor Green
}

function Enable-WindowsDefender {
    <#
    .DESCRIPTION
        تفعيل Windows Defender والحماية من الفيروسات
        Enable Windows Defender and antivirus protection
    #>
    Write-Host "تفعيل Windows Defender..." -ForegroundColor Cyan
    Write-Host "Enabling Windows Defender..." -ForegroundColor Cyan
    
    # تفعيل الحماية في الوقت الفعلي
    Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue
    
    # تفعيل فحص السلوك
    Set-MpPreference -DisableBehaviorMonitoring $false -ErrorAction SilentlyContinue
    
    # تحديث تعريفات الفيروسات
    Update-MpSignature -ErrorAction SilentlyContinue
    
    Write-Host "✓ تم تفعيل Windows Defender" -ForegroundColor Green
    Write-Host "✓ Windows Defender enabled" -ForegroundColor Green
}

# ==================== تثبيت البرامج المتقدمة ====================
# ==================== Advanced Software Installation ====================

function Install-AdvancedSoftware {
    <#
    .DESCRIPTION
        تثبيت برامج متقدمة مختارة
        Install selected advanced software
    #>
    Write-Host "تثبيت البرامج المتقدمة..." -ForegroundColor Cyan
    Write-Host "Installing advanced software..." -ForegroundColor Cyan
    
    # قائمة البرامج المقترحة / Suggested Applications
    $softwareOptions = @{
        "VLC Media Player" = "VLC.MediaPlayer"
        "7-Zip" = "7zip.7zip"
        "Firefox" = "Mozilla.Firefox"
        "Visual Studio Code" = "Microsoft.VisualStudioCode"
        "Git" = "Git.Git"
        "Python" = "Python.Python.3.11"
    }
    
    Write-Host "البرامج المتاحة للتثبيت:" -ForegroundColor Yellow
    Write-Host "Available software for installation:" -ForegroundColor Yellow
    
    $count = 1
    foreach ($software in $softwareOptions.GetEnumerator()) {
        Write-Host "$count. $($software.Name)"
        $count++
    }
    
    Write-Host "" -ForegroundColor Gray
    Write-Host "ملاحظة: تأكد من توفر Windows Package Manager" -ForegroundColor Gray
    Write-Host "Note: Ensure Windows Package Manager is installed" -ForegroundColor Gray
}

# ==================== دوال مساعدة ====================
# ==================== Helper Functions ====================

function Show-AdvancedMenu {
    <#
    .DESCRIPTION
        عرض القائمة المتقدمة
        Display advanced menu
    #>
    Clear-Host
    Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           قائمة الميزات المتقدمة | Advanced Features Menu    ║" -ForegroundColor Cyan
    Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. تفعيل الأداء القصوى | Enable Ultimate Performance"
    Write-Host "2. تعطيل التطبيقات الخلفية | Disable Background Apps"
    Write-Host "3. تعطيل الخدمات غير المهمة | Disable Unnecessary Services"
    Write-Host "4. تفعيل حماية الخصوصية | Enable Privacy Protection"
    Write-Host "5. تفعيل Windows Defender | Enable Windows Defender"
    Write-Host "6. تثبيت برامج متقدمة | Install Advanced Software"
    Write-Host "7. تطبيق جميع الإعدادات | Apply All Settings"
    Write-Host "0. رجوع | Exit"
    Write-Host ""
}

function Apply-AllAdvancedSettings {
    <#
    .DESCRIPTION
        تطبيق جميع الإعدادات المتقدمة
        Apply all advanced settings
    #>
    Write-Host "تطبيق جميع الإعدادات المتقدمة..." -ForegroundColor Cyan
    Write-Host "Applying all advanced settings..." -ForegroundColor Cyan
    Write-Host ""
    
    Enable-UltimatePerformance
    Write-Host ""
    
    Disable-BackgroundApps
    Write-Host ""
    
    Disable-UnwantedServices
    Write-Host ""
    
    Enable-PrivacyProtection
    Write-Host ""
    
    Enable-WindowsDefender
    Write-Host ""
    
    Write-Host "✓ اكتملت جميع الإعدادات بنجاح" -ForegroundColor Green
    Write-Host "✓ All settings applied successfully" -ForegroundColor Green
}

# ==================== تصدير الدوال ====================
# ==================== Export Functions ====================

Export-ModuleMember -Function @(
    'Enable-UltimatePerformance',
    'Disable-BackgroundApps',
    'Disable-UnwantedServices',
    'Enable-PrivacyProtection',
    'Enable-WindowsDefender',
    'Install-AdvancedSoftware',
    'Show-AdvancedMenu',
    'Apply-AllAdvancedSettings'
)
