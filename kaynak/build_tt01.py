# -*- coding: utf-8 -*-
# tt01.pc (Ingilizce slot) Turkce ceviri uygulayici (KANONIK builder)
# - Yontem: yamayi DOGRUDAN Ingilizcenin uzerine gomer (klasik TR yama).
#   Oyun varsayilan acilir, dil secmeye gerek yok, acilista sifirlanma olmaz.
# - tr_*.py dosyalarindaki T sozluklerini (KEY -> Turkce metin) birlestirir
# - ikame uygular: s g i I  (gercek TR: s->s, g->g, dotless-i->i, dotted-I->I)
# - o c u O C U dokunmadan korunur
# - {STR_...}, ^xxx^000, ~, %s, {0} kodlari metnin icinde aynen kalir
# - HER ZAMAN temiz Ingilizce yedekten okur (BASE), canli dosyaya yazar (OUT)
import re, glob, os, io, importlib.util

WORK = r"C:\XboxGames\_APT_TR_WORK"
OUT  = r"c:\XboxGames\A Plague Tale- Requiem - Windows\Content\TRTEXT\tt01.pc"
BASE = r"c:\XboxGames\A Plague Tale- Requiem - Windows\Content\_TR_TEST_BACKUP\tt01.pc"

# --- TR karakter ikamesi (yalnizca bu 6 harf) ---
SUB = str.maketrans({'ş':'s','Ş':'S','ğ':'g','Ğ':'G','ı':'i','İ':'I'})
def subst(s): return s.translate(SUB)

# --- tum tr_*.py dosyalarini yukle ---
T = {}
files = sorted(glob.glob(os.path.join(WORK, "tr_*.py")))
for fn in files:
    spec = importlib.util.spec_from_file_location(os.path.splitext(os.path.basename(fn))[0], fn)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    d = getattr(mod, "T", {})
    dup = set(T) & set(d)
    if dup:
        print(f"UYARI: {fn} cakisan anahtar: {list(dup)[:5]}")
    T.update(d)
    print(f"  yuklendi {os.path.basename(fn)}: {len(d)} kayit")
print(f"Toplam ceviri kaydi: {len(T)}")

if not os.path.exists(BASE):
    raise SystemExit(f"HATA: temiz Ingilizce taban yok: {BASE}")

raw = open(BASE, encoding="utf-8").read()
nl = "\r\n" if "\r\n" in raw else "\n"
lines = raw.split(nl)

pat = re.compile(r'^TT\s+(\d+)\s+"(.*)"\s+(\S+)\s*$')
applied = 0
missing_codes = []
out = []
for line in lines:
    m = pat.match(line)
    if m:
        num, body, key = m.group(1), m.group(2), m.group(3)
        if key in T:
            tr = T[key]
            en_codes = set(re.findall(r'\{[^}]+\}', body))
            tr_codes = set(re.findall(r'\{[^}]+\}', tr))
            if en_codes != tr_codes:
                missing_codes.append((key, en_codes ^ tr_codes))
            new = subst(tr)
            line = f'TT {num} "{new}" {key}'
            applied += 1
    out.append(line)

out_text = nl.join(out)
# UTF-8, BOM yok, newline cevirisi yok
with io.open(OUT, "w", encoding="utf-8", newline="") as f:
    f.write(out_text)

nl_label = "CRLF" if nl == "\r\n" else "LF"
print(f"\nUYGULANAN: {applied} satir  |  newline={nl_label}")
if missing_codes:
    print(f"!! KOD UYUSMAZLIGI ({len(missing_codes)}):")
    for k, diff in missing_codes[:15]:
        print(f"   {k}: {diff}")
else:
    print("Kod butunlugu: TAMAM (tum {STR_..} kodlari korunmus)")
print("Yazildi:", OUT)
