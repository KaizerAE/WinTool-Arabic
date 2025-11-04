# واجهة رسومية لـ WinTool-Arabic
# GUI for WinTool-Arabic
# Created by Kaizer

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# إنشاء النموذج الرئيسي
$form = New-Object System.Windows.Forms.Form
$form.Text = 'kaizer'
$form.Size = New-Object System.Drawing.Size(600,500)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(45,45,48)
$form.ForeColor = [System.Drawing.Color]::White
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# عنوان البرنامج
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Location = New-Object System.Drawing.Point(10,20)
$labelTitle.Size = New-Object System.Drawing.Size(560,40)
$labelTitle.Text = 'WinTool-Arabic - أدوات ويندوز'
$labelTitle.Font = New-Object System.Drawing.Font('Segoe UI',16,[System.Drawing.FontStyle]::Bold)
$labelTitle.TextAlign = 'MiddleCenter'
$labelTitle.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($labelTitle)

# صندوق الخيارات
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Point(20,80)
$groupBox.Size = New-Object System.Drawing.Size(550,300)
$groupBox.Text = 'خيارات التفعيل والإغلاق'
$groupBox.ForeColor = [System.Drawing.Color]::LightGray
$groupBox.Font = New-Object System.Drawing.Font('Segoe UI',10)
$form.Controls.Add($groupBox)

# إنشاء الأزرار المرقمة
$yPosition = 30
$options = @(
    @{Number='1'; Text='تفعيل Windows Defender'}
    @{Number='2'; Text='إيقاف Windows Defender'}
    @{Number='3'; Text='تفعيل Windows Update'}
    @{Number='4'; Text='إيقاف Windows Update'}
    @{Number='5'; Text='تفعيل Firewall'}
    @{Number='6'; Text='إيقاف Firewall'}
    @{Number='7'; Text='تنظيف ملفات النظام'}
    @{Number='8'; Text='تحسين أداء النظام'}
)

foreach ($option in $options) {
    $button = New-Object System.Windows.Forms.Button
    $button.Location = New-Object System.Drawing.Point(20,$yPosition)
    $button.Size = New-Object System.Drawing.Size(500,30)
    $button.Text = "$($option.Number). $($option.Text)"
    $button.Font = New-Object System.Drawing.Font('Segoe UI',9)
    $button.BackColor = [System.Drawing.Color]::FromArgb(63,63,70)
    $button.ForeColor = [System.Drawing.Color]::White
    $button.FlatStyle = 'Flat'
    $button.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(85,85,85)
    $button.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(75,75,82)
    $button.Tag = $option.Number
    $button.Add_Click({
        $selectedOption = $this.Tag
        [System.Windows.Forms.MessageBox]::Show(
            "تم اختيار الخيار رقم: $selectedOption`n`nسيتم تنفيذ العملية...`n",
            'تأكيد',
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    })
    $groupBox.Controls.Add($button)
    $yPosition += 35
}

# زر الخروج
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Location = New-Object System.Drawing.Point(450,400)
$btnExit.Size = New-Object System.Drawing.Size(120,40)
$btnExit.Text = 'إغلاق'
$btnExit.Font = New-Object System.Drawing.Font('Segoe UI',10,[System.Drawing.FontStyle]::Bold)
$btnExit.BackColor = [System.Drawing.Color]::FromArgb(200,50,50)
$btnExit.ForeColor = [System.Drawing.Color]::White
$btnExit.FlatStyle = 'Flat'
$btnExit.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(150,40,40)
$btnExit.Add_Click({ $form.Close() })
$form.Controls.Add($btnExit)

# عرض النموذج
$form.ShowDialog() | Out-Null
