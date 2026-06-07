# A Plague Tale: Requiem — Türkçe Yama

A Plague Tale: Requiem oyununun **arayüz ve altyazılarını Türkçeleştiren** gayriresmî fan çeviri yamasıdır. Ses İngilizce kalır; tüm menüler, ipuçları, görevler ve oyun-içi diyalog altyazıları Türkçedir (~16.000 satır).

> Çeviri: **MiAsimBilir**

---

## ✨ Özellikler

- Menü, ayarlar, HUD, görevler, eğitim ipuçları, başarımlar, eşya/loot adları — **tamamı Türkçe**.
- 17 bölümün tüm hikâye diyalogları + bölümsüz ortam sesleri (haydut/asker/halk) **altyazılı Türkçe**.
- Tek dosyalık temiz yama: yalnızca `Content/TRTEXT/tt01.pc` değişir. Font, kayıt dosyaları, başka hiçbir şey ellenmez.

## 🎮 Gereksinimler

- **A Plague Tale: Requiem** — Xbox / Microsoft Store (GDK) sürümü, **v1.6.0.0** üzerinde test edildi.
- Oyunun kurulu olduğu klasör (örn. `C:\XboxGames\A Plague Tale- Requiem - Windows`).
- Steam/GOG sürümünde de `tt01.pc` aynı yapıda olduğundan büyük olasılıkla çalışır (test edilmedi).

---

## 📥 Kurulum

### Yöntem 1 — Otomatik (önerilen, çift tıkla)
1. Bu depoyu indir (**Code → Download ZIP**) ve bir klasöre çıkar.
2. **`KUR (cift tikla).bat`** dosyasına **çift tıkla**. (Açılan kurulum penceresi oyunu otomatik bulur, **orijinal dosyanı yedekler** ve yamayı kurar.)
   - Windows SmartScreen uyarı verirse: **Ek bilgi → Yine de çalıştır**.
   - Alternatif: `kur.ps1` dosyasına sağ tık → "PowerShell ile çalıştır".

> Not: Güvenlik için kurulum **derlenmiş .exe değil, okunabilir betiktir** — `.ps1` dosyasını Not Defteri'nde açıp ne yaptığını görebilirsin. `.bat` yalnızca betiği çift tıkla çalıştıran kısa bir başlatıcıdır.

### Yöntem 2 — Elle kurulum
1. Oyun klasöründe şu dosyayı bul:
   `...\A Plague Tale- Requiem - Windows\Content\TRTEXT\tt01.pc`
2. Bu dosyanın bir **yedeğini al** (örn. `tt01.pc.orijinal_yedek` olarak kopyala).
3. Depodaki `yama\Content\TRTEXT\tt01.pc` dosyasını, oyundaki aynı yere **kopyala/değiştir**.

### ⚙️ Oyun-içi dil ayarı
Çeviri, oyunun **İngilizce** metninin üzerine yazıldığı için:
> **Seçenekler → Dil** bölümünde **"Metin dili"** ve **"Altyazı dili"** = **English(US)** olmalı.
> Bu seçeneklerde metin ve altyazılar Türkçe görünür. **Ses** İngilizce kalır.

---

## 🗑️ Kaldırma

- **`KALDIR (cift tikla).bat`** dosyasına çift tıkla → orijinal İngilizce dosya geri yüklenir.
- Ya da elle: yedeklediğin `tt01.pc.orijinal_yedek` dosyasını geri kopyala.
- Yedeğin yoksa: **Xbox uygulaması → oyun → Yönet → Dosyaları doğrula/onar**.

---

## ⚠️ Bilinen sınırlamalar

- **Türkçe karakterler:** Oyunun fontunda `ş ğ ı İ` glyph'leri yoktur (bu sürümde font değiştirilemiyor). Bu yüzden yamada bu harfler en yakın karşılıklarıyla yazılır:
  `ş→s`, `ğ→g`, `ı→i`, `İ→I`. Buna karşılık **`ö ç ü Ö Ç Ü` doğru ve eksiksiz** görünür.
- Birkaç **ön-render (video) sinematikte** altyazı İngilizce kalabilir (bu altyazılar videonun içine gömülüdür, metin dosyasından bağımsızdır). Tüm motor-içi diyaloglar Türkçedir.

---

## 🛠️ Kaynak / yeniden derleme

`kaynak/` klasöründe çeviri kaynak dosyaları (`tr_*.py`) ve derleyici (`build_tt01.py`) bulunur.
- Çeviri metinleri kaynakta **tam Türkçe karakterle** tutulur; `ş→s` vb. ikame **derleme anında** uygulanır. (Font ileride çözülürse ikame satırını silip kusursuz metin elde edilebilir.)
- Yeniden derlemek için, derleyicinin okuduğu temiz İngilizce **taban dosyasını** kendi oyununuzdaki orijinal `tt01.pc`'den sağlamanız gerekir (telif nedeniyle bu depoda dağıtılmaz).

---

## 📜 Yasal uyarı

Bu, **gayriresmî bir hayran çevirisidir**. Focus Entertainment veya Asobo Studio ile bir ilişkisi, onayı yoktur. A Plague Tale: Requiem ve tüm ilgili haklar sahiplerine aittir. Yama yalnızca oyunun yasal bir kopyasına sahip kullanıcılar içindir; ticari amaçla kullanılamaz/satılamaz.
