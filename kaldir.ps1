# =====================================================================
#  A Plague Tale: Requiem - Turkce Yama KALDIRMA Betigi
#  Orijinal Ingilizce dosyayi geri yukler.
# =====================================================================
param([string]$GamePath)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=== Turkce Yama Kaldirma ===" -ForegroundColor Cyan
Write-Host ""

function Test-GameRoot([string]$p) {
    if ([string]::IsNullOrWhiteSpace($p)) { return $false }
    return (Test-Path (Join-Path $p "Content\TRTEXT\tt01.pc"))
}

if (-not (Test-GameRoot $GamePath)) {
    $found = @()
    foreach ($d in (Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue)) {
        $try = Join-Path $d.Root "XboxGames\A Plague Tale- Requiem - Windows"
        if (Test-GameRoot $try) { $found += $try }
    }
    if ($found.Count -ge 1) {
        $GamePath = $found[0]
        Write-Host "Oyun bulundu: $GamePath" -ForegroundColor Green
    } else {
        Write-Host "Oyunun ANA klasorunu girin:"
        $GamePath = (Read-Host "Yol").Trim().Trim('"')
    }
}

if (-not (Test-GameRoot $GamePath)) {
    Write-Host "HATA: Gecerli bir oyun klasoru degil." -ForegroundColor Red
    Read-Host "Cikmak icin Enter'a basin"; exit 1
}

$target = Join-Path $GamePath "Content\TRTEXT\tt01.pc"
$backup = "$target.orijinal_yedek"

if (Test-Path $backup) {
    Copy-Item $backup $target -Force
    Remove-Item $backup -Force
    Write-Host ""
    Write-Host "Orijinal dosya geri yuklendi. Yama kaldirildi." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Yedek dosya (tt01.pc.orijinal_yedek) bulunamadi." -ForegroundColor Yellow
    Write-Host "Orijinali geri almak icin: Xbox uygulamasi > A Plague Tale: Requiem >"
    Write-Host "  ... menusu > Yonet > Dosyalari dogrula/onar."
}
Read-Host "Cikmak icin Enter'a basin"
