# WinTool-Arabic - واجهة برنامج إدارة ويندوز شاملة
# تصميم شبيه WinUtil (Chris Titus Tech)
# Author: Kaizer

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'WinTool-Arabic - أدوات ويندوز'
$form.Size = New-Object System.Drawing.Size(820, 670)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(36, 36, 40)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# --- Tabs Section ---
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Location = New-Object System.Drawing.Point(10, 60)
$tabControl.Size = New-Object System.Drawing.Size(780, 580)
$tabControl.Font = New-Object System.Drawing.Font('Segoe UI', 10)
$tabControl.BackColor = [System.Drawing.Color]::FromArgb(36,36,40)
$tabControl.ForeColor = [System.Drawing.Color]::White

# Tabs: Install, Tweaks, Config, Updates, MicroWin
$tabs = @(
    @{name='Install'; caption='تثبيت البرامج';},
    @{name='Tweaks'; caption='تعديلات وتحسينات';},
    @{name='Config'; caption='الإعدادات';},
    @{name='Updates'; caption='التحديثات';},
    @{name='MicroWin'; caption='أدوات إضافية'}
)

$tabPages = @{}
foreach ($t in $tabs) {
    $tp = New-Object System.Windows.Forms.TabPage
    $tp.Text = $t.caption
    $tp.Name = $t.name
    $tp.BackColor = [System.Drawing.Color]::FromArgb(36,36,40)
    $tp.ForeColor = [System.Drawing.Color]::White
    $tabPages[$t.name] = $tp
    $tabControl.Controls.Add($tp)
}

# -------------- Tweaks Page --------------
$tweaksPanel = New-Object System.Windows.Forms.Panel
$tweaksPanel.Dock = 'Fill'
$tweaksPanel.AutoScroll = $true
$tabPages['Tweaks'].Controls.Add($tweaksPanel)

$y = 10
$checkboxes = @()
$tweaksList = @(
    @{txt='تعطيل Telemetry وتتبع مايكروسوفت';var='DisableTelemetry';desc='إيقاف إرسال بيانات الاستخدام إلى مايكروسوفت.'},
    @{txt='إزالة البرامج المثبتة مسبقاً (Debloat)';var='RemoveBloatware';desc='حذف تطبيقات مثل Candy Crush.'},
    @{txt='تفعيل الوضع المظلم';var='EnableDarkMode';desc='تطبيق الثيم المظلم على الويندوز.'},
    @{txt='مركز شريط المهام';var='TaskbarCenter';desc='جعل رموز شريط المهام في المنتصف.'},
    @{txt='إظهار زر البحث';var='ShowSearchButton';desc='إظهار زر البحث بجانب القائمة.'},
    @{txt='إظهار امتدادات الملفات';var='ShowFileExtensions';desc='عرض امتدادات جميع الملفات.'},
    @{txt='تعطيل OneDrive';var='DisableOneDrive';desc='إيقاف مزامنة التخزين السحابي.'},
    @{txt='تعطيل Cortana';var='DisableCortana';desc='إيقاف المساعد الصوتي Cortana.'},
    @{txt='تفعيل Ultimate Performance';var='EnableUltimatePower';desc='تفعيل أفضل خطط الطاقة.'},
    @{txt='إيقاف الخدمات غير الضرورية';var='DisableUnneededServices';desc='إيقاف خدمات غير هامة للأداء.'},
    @{txt='زيادة سرعة إقلاع الويندوز';var='FasterStartup';desc='إلغاء البرامج من بدء التشغيل.'},
    @{txt='تعطيل الإعلانات بالنظام';var='DisableSystemAds';desc='إيقاف الإعلانات في القائمة والإشعارات.'}
)
foreach ($tw in $tweaksList) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $tw.txt
    $cb.Name = $tw.var
    $cb.AutoSize = $true
    $cb.Location = New-Object System.Drawing.Point(20, $y)
    $cb.ForeColor = [System.Drawing.Color]::White
    $cb.Font = New-Object System.Drawing.Font('Segoe UI', 12)
    $descLbl = New-Object System.Windows.Forms.Label
    $descLbl.Text = $tw.desc
    $descLbl.Location = New-Object System.Drawing.Point(300, $y+2)
    $descLbl.Size = New-Object System.Drawing.Size(400, 28)
    $descLbl.Font = New-Object System.Drawing.Font('Segoe UI',10)
    $descLbl.ForeColor = [System.Drawing.Color]::LightGray
    $tweaksPanel.Controls.Add($cb)
    $tweaksPanel.Controls.Add($descLbl)
    $checkboxes += $cb
    $y += 38
}

# زر تطبيق التعديلات
$btnApplyTweaks = New-Object System.Windows.Forms.Button
$btnApplyTweaks.Text = 'تطبيق التعديلات المحددة'
$btnApplyTweaks.Location = New-Object System.Drawing.Point(20, $y+20)
$btnApplyTweaks.Size = New-Object System.Drawing.Size(200,40)
$btnApplyTweaks.Font = New-Object System.Drawing.Font('Segoe UI',12)
$btnApplyTweaks.BackColor = [System.Drawing.Color]::FromArgb(69,183,61)
$btnApplyTweaks.ForeColor = [System.Drawing.Color]::White
$btnApplyTweaks.FlatStyle = 'Flat'
$btnApplyTweaks.Add_Click({
    $result = @()
    foreach ($cb in $checkboxes) { if ($cb.Checked) { $result += $cb.Text; } }
    [Windows.Forms.MessageBox]::Show("سيتم تنفيذ التعديلات التالية:`n"+$($result -join "`n"),'تطبيق التعديلات',[Windows.Forms.MessageBoxButtons]::OK,[Windows.Forms.MessageBoxIcon]::Information)
    # هنا يتم تنفيذ الأوامر البرمجية (للتعديلات)
})
$tweaksPanel.Controls.Add($btnApplyTweaks)

# زر استعادة الوضع الافتراضي
$btnRestoreDef = New-Object System.Windows.Forms.Button
$btnRestoreDef.Text = 'استعادة الوضع الافتراضي'
$btnRestoreDef.Location = New-Object System.Drawing.Point(240, $y+20)
$btnRestoreDef.Size = New-Object System.Drawing.Size(200,40)
$btnRestoreDef.Font = New-Object System.Drawing.Font('Segoe UI',12)
$btnRestoreDef.BackColor = [System.Drawing.Color]::FromArgb(176,57,57)
$btnRestoreDef.ForeColor = [System.Drawing.Color]::White
$btnRestoreDef.FlatStyle = 'Flat'
$btnRestoreDef.Add_Click({
    [Windows.Forms.MessageBox]::Show('سيتم إعادة جميع الخيارات للإعدادات الافتراضية','استعادة',[Windows.Forms.MessageBoxButtons]::OK,[Windows.Forms.MessageBoxIcon]::Information)
    foreach ($cb in $checkboxes) { $cb.Checked = $false }
})
$tweaksPanel.Controls.Add($btnRestoreDef)

# -------------- Install Page --------------
$installPanel = New-Object System.Windows.Forms.Panel
$installPanel.Dock = 'Fill'
$installPanel.AutoScroll = $true
$tabPages['Install'].Controls.Add($installPanel)

$y2 = 10
$programsList = @(
    @{txt='Google Chrome';var='Chrome'},
    @{txt='Mozilla Firefox';var='Firefox'},
    @{txt='VLC Media Player';var='VLC'},
    @{txt='7-Zip';var='7zip'},
    @{txt='Git';var='Git'},
    @{txt='VS Code';var='VSCode'},
    @{txt='Telegram';var='Telegram'},
    @{txt='Discord';var='Discord'},
    @{txt='Notepad++';var='Notepad++'},
    @{txt='WinRAR';var='WinRAR'},
    @{txt='PowerToys';var='PowerToys'}
)
$progCheckBoxes = @()
foreach ($pr in $programsList) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $pr.txt
    $cb.Name = $pr.var
    $cb.AutoSize = $true
    $cb.Location = New-Object System.Drawing.Point(20, $y2)
    $cb.ForeColor = [System.Drawing.Color]::White
    $cb.Font = New-Object System.Drawing.Font('Segoe UI', 12)
    $installPanel.Controls.Add($cb)
    $progCheckBoxes += $cb
    $y2 += 36
}

$btnInstallPgms = New-Object System.Windows.Forms.Button
$btnInstallPgms.Text = 'تثبيت البرامج المحددة'
$btnInstallPgms.Location = New-Object System.Drawing.Point(20, $y2+10)
$btnInstallPgms.Size = New-Object System.Drawing.Size(200,40)
$btnInstallPgms.Font = New-Object System.Drawing.Font('Segoe UI',12)
$btnInstallPgms.BackColor = [System.Drawing.Color]::FromArgb(32,146,243)
$btnInstallPgms.ForeColor = [System.Drawing.Color]::White
$btnInstallPgms.FlatStyle = 'Flat'
$btnInstallPgms.Add_Click({
    $result = @()
    foreach ($cb in $progCheckBoxes) { if ($cb.Checked) { $result += $cb.Text; } }
    [Windows.Forms.MessageBox]::Show("سيتم تثبيت البرامج التالية:`n"+$($result -join "`n"),'تثبيت البرامج',[Windows.Forms.MessageBoxButtons]::OK,[Windows.Forms.MessageBoxIcon]::Information)
    # هنا يتم تنفيذ أوامر Winget أو Chocolatey
})
$installPanel.Controls.Add($btnInstallPgms)

# -------------- Config Page --------------
$configPanel = New-Object System.Windows.Forms.Panel
$configPanel.Dock = 'Fill'
$configPanel.AutoScroll = $true
$tabPages['Config'].Controls.Add($configPanel)

$y3 = 10
$configList = @(
    @{txt='تفعيل وضع الأداء العالي';desc='ضبط إعدادات الطاقة لأداء أقوى.'},
    @{txt='تغيير اللغة إلى العربية';desc='تحويل واجهة النظام إلى اللغة العربية.'},
    @{txt='تعديل إعدادات الخصوصية';desc='ضبط ميزات الخصوصية بحسب رغبتك.'},
    @{txt='إعداد نقطة استعادة النظام';desc='إنشاء Restore Point قبل أي تغييرات.'}
)
foreach ($cfg in $configList) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $cfg.txt
    $cb.AutoSize = $true
    $cb.Font = New-Object System.Drawing.Font('Segoe UI',11)
    $cb.Location = New-Object System.Drawing.Point(20,$y3)
    $cb.ForeColor = [System.Drawing.Color]::White
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = $cfg.desc
    $lbl.Location = New-Object System.Drawing.Point(320, $y3+2)
    $lbl.Size = New-Object System.Drawing.Size(400,28)
    $lbl.Font = New-Object System.Drawing.Font('Segoe UI',9)
    $lbl.ForeColor = [System.Drawing.Color]::LightGray
    $configPanel.Controls.Add($cb)
    $configPanel.Controls.Add($lbl)
    $y3 += 38
}

# -------------- Updates Page --------------
$updatesPanel = New-Object System.Windows.Forms.Panel
$updatesPanel.Dock = 'Fill'
$updatesPanel.AutoScroll = $true
$tabPages['Updates'].Controls.Add($updatesPanel)

$y4 = 10
$updatesList = @(
    @{txt='إيقاف التحديثات الإجبارية';desc='منع فرض التحديثات من ويندوز.'},
    @{txt='تحديث جميع البرامج';desc='تشغيل تحديث شامل لكل البرامج.'},
    @{txt='تحديث النظام الآن';desc='تشغيل Windows Update فوراً.'}
)
foreach ($up in $updatesList) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $up.txt
    $cb.AutoSize = $true
    $cb.Font = New-Object System.Drawing.Font('Segoe UI',11)
    $cb.Location = New-Object System.Drawing.Point(20,$y4)
    $cb.ForeColor = [System.Drawing.Color]::White
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = $up.desc
    $lbl.Location = New-Object System.Drawing.Point(320, $y4+2)
    $lbl.Size = New-Object System.Drawing.Size(400,28)
    $lbl.Font = New-Object System.Drawing.Font('Segoe UI',9)
    $lbl.ForeColor = [System.Drawing.Color]::LightGray
    $updatesPanel.Controls.Add($cb)
    $updatesPanel.Controls.Add($lbl)
    $y4 += 38
}

# -------------- MicroWin Page (Extra tools) --------------
$microPanel = New-Object System.Windows.Forms.Panel
$microPanel.Dock = 'Fill'
$microPanel.AutoScroll = $true
$tabPages['MicroWin'].Controls.Add($microPanel)
$y5 = 10
$extrasList = @(
    @{txt='مدير العمليات المتقدمة';desc='قم بفحص وإغلاق العمليات تلقائياً.'},
    @{txt='تنظيف الريجستري';desc='تنظيف وحذف الإدخالات غير المهمة.'},
    @{txt='تشخيص مشاكل الانترنت';desc='تشغيل أداة فحص الشبكة.'}
)
foreach ($ex in $extrasList) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $ex.txt
    $cb.AutoSize = $true
    $cb.Font = New-Object System.Drawing.Font('Segoe UI',11)
    $cb.Location = New-Object System.Drawing.Point(20,$y5)
    $cb.ForeColor = [System.Drawing.Color]::White
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = $ex.desc
    $lbl.Location = New-Object System.Drawing.Point(320, $y5+2)
    $lbl.Size = New-Object System.Drawing.Size(400,28)
    $lbl.Font = New-Object System.Drawing.Font('Segoe UI',9)
    $lbl.ForeColor = [System.Drawing.Color]::LightGray
    $microPanel.Controls.Add($cb)
    $microPanel.Controls.Add($lbl)
    $y5 += 38
}

# --- إضافة عنصر رئيسي أعلى الصفحة (العنوان) ---
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Location = New-Object System.Drawing.Point(12,12)
$labelTitle.Size = New-Object System.Drawing.Size(780,40)
$labelTitle.Font = New-Object System.Drawing.Font('Segoe UI',20,[System.Drawing.FontStyle]::Bold)
$labelTitle.Text = 'WinTool-Arabic - Advanced Windows Utility'
$labelTitle.ForeColor = [System.Drawing.Color]::White
$labelTitle.TextAlign = 'MiddleCenter'
$form.Controls.Add($labelTitle)
$form.Controls.Add($tabControl)
$form.ShowDialog() | Out-Null
