# =====================================================================
#  A Plague Tale: Requiem - Turkce Yama Kurulum Betigi
#  Kullanim:  sag tik -> "PowerShell ile calistir"
#  veya:      powershell -ExecutionPolicy Bypass -File kur.ps1
#  Istege bagli: kur.ps1 -GamePath "D:\XboxGames\A Plague Tale- Requiem - Windows"
# =====================================================================
param([string]$GamePath)

$ErrorActionPreference = "Stop"
$ScriptDir  = $PSScriptRoot
$PatchFile  = Join-Path $ScriptDir "yama\Content\TRTEXT\tt01.pc"

Write-Host ""
Write-Host "=== A Plague Tale: Requiem - Turkce Yama ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $PatchFile)) {
    Write-Host "HATA: Yama dosyasi bulunamadi:" -ForegroundColor Red
    Write-Host "  $PatchFile"
    Write-Host "Bu betigi, indirdiginiz klasorun ICINDEN calistirin."
    Read-Host "Cikmak icin Enter'a basin"; exit 1
}

function Test-GameRoot([string]$p) {
    if ([string]::IsNullOrWhiteSpace($p)) { return $false }
    return (Test-Path (Join-Path $p "Content\TRTEXT\tt01.pc"))
}

# 1) Parametreyle verildiyse onu kullan
if (-not (Test-GameRoot $GamePath)) {
    # 2) Surucalerde otomatik ara
    Write-Host "Oyun klasoru araniyor..." -ForegroundColor Gray
    $found = @()
    foreach ($d in (Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue)) {
        $try = Join-Path $d.Root "XboxGames\A Plague Tale- Requiem - Windows"
        if (Test-GameRoot $try) { $found += $try }
    }
    if ($found.Count -ge 1) {
        $GamePath = $found[0]
        Write-Host "Oyun bulundu: $GamePath" -ForegroundColor Green
    } else {
        # 3) Kullanicidan iste
        Write-Host "Oyun otomatik bulunamadi." -ForegroundColor Yellow
        Write-Host "Oyunun ANA klasorunu girin (icinde 'Content' klasoru olan):"
        Write-Host "  Ornek: C:\XboxGames\A Plague Tale- Requiem - Windows"
        $GamePath = (Read-Host "Yol").Trim().Trim('"')
    }
}

if (-not (Test-GameRoot $GamePath)) {
    Write-Host "HATA: Gecerli bir oyun klasoru degil:" -ForegroundColor Red
    Write-Host "  $GamePath"
    Write-Host "Content\TRTEXT\tt01.pc bu klasorde bulunamadi."
    Read-Host "Cikmak icin Enter'a basin"; exit 1
}

$target = Join-Path $GamePath "Content\TRTEXT\tt01.pc"
$backup = "$target.orijinal_yedek"

# Orijinali yedekle (yalnizca ilk kurulumda; mevcut yedegi EZME)
if (-not (Test-Path $backup)) {
    Copy-Item $target $backup -Force
    Write-Host "Orijinal dosya yedeklendi:" -ForegroundColor Green
    Write-Host "  $backup"
} else {
    Write-Host "Yedek zaten mevcut, korunuyor:" -ForegroundColor Yellow
    Write-Host "  $backup"
}

# Yamayi uygula
Copy-Item $PatchFile $target -Force

Write-Host ""
Write-Host "KURULUM TAMAMLANDI!" -ForegroundColor Green
Write-Host ""
Write-Host "Oyun-ici ayar: Secenekler > Dil bolumunde" -ForegroundColor Cyan
Write-Host "  'Metin dili' ve 'Altyazi dili' = English(US) olmali."
Write-Host "  (Ceviri Ingilizce metnin uzerine yazildigi icin boyle gorunur;"
Write-Host "   secince metin ve altyazilar Turkce gelir. Ses Ingilizce kalir.)"
Write-Host ""
Write-Host "Geri almak icin: kaldir.ps1" -ForegroundColor Gray
Read-Host "Cikmak icin Enter'a basin"
