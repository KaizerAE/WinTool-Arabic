# موديول تثبيت البرامج
# Install Programs Module

function Install-Programs {
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "   تثبيت البرامج الأساسية   " -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""

    # التحقق من وجود Chocolatey
    Write-Host "التحقق من وجود Chocolatey..." -ForegroundColor Yellow
    
    if (!(Test-Path "$env:ProgramData\chocolatey\choco.exe")) {
        Write-Host "Chocolatey غير مثبت. بدء التثبيت..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        try {
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Host "Chocolatey تم تثبيته بنجاح!" -ForegroundColor Green
        }
        catch {
            Write-Host "فشل تثبيت Chocolatey: $_" -ForegroundColor Red
            return
        }
    }
    else {
        Write-Host "Chocolatey مثبت بالفعل." -ForegroundColor Green
    }

    # قائمة البرامج للتثبيت
    $programs = @(
        "googlechrome",
        "firefox",
        "7zip",
        "vlc",
        "vscode",
        "notepadplusplus",
        "git",
        "python"
    )

    Write-Host ""
    Write-Host "البرامج التي سيتم تثبيتها:" -ForegroundColor Cyan
    $programs | ForEach-Object { Write-Host "  - $_" }
    Write-Host ""

    $confirm = Read-Host "هل تريد المتابعة? (Y/N)"
    
    if ($confirm -eq 'Y' -or $confirm -eq 'y') {
        foreach ($program in $programs) {
            Write-Host "جاري تثبيت $program..." -ForegroundColor Yellow
            try {
                choco install $program -y
                Write-Host "$program تم تثبيته بنجاح!" -ForegroundColor Green
            }
            catch {
                Write-Host "فشل تثبيت $program" -ForegroundColor Red
            }
        }
        Write-Host ""
        Write-Host "تم الانتهاء من تثبيت البرامج!" -ForegroundColor Green
    }
    else {
        Write-Host "تم الغاء العملية." -ForegroundColor Yellow
    }
}
