# Godot Oyununu App Store'a Yükleme (Adım Adım)

Bu rehber, mevcut `Zıplayan Dino` projesini iOS için hazırlayıp App Store'a göndermek içindir.

## 1) Zorunlu gereksinimler

- Bir **Mac** bilgisayar (Xcode sadece macOS'ta çalışır).
- **Apple Developer Program** üyeliği (yayın için zorunlu).
- **Xcode** (güncel sürüm).
- Godot 4.x (projeyi iOS için export etmek için).

## 2) Apple tarafı hazırlık

1. [developer.apple.com](https://developer.apple.com) üzerinden hesabını aktif et.
2. App Store Connect'e girip yeni uygulama kaydı aç:
   - Platform: iOS
   - Name: Uygulama adı
   - Bundle ID: ters alan adı formatı (`com.seninmarkan.ziplayandino`)
3. Bu Bundle ID ile Godot export ayarındaki Bundle Identifier birebir aynı olmalı.

## 3) Godot iOS export ayarı

1. Projeyi Godot'da aç.
2. `Project > Export...` menüsüne gir.
3. `Add... > iOS` profili ekle.
4. iOS export içinde şu alanları doldur:
   - Bundle Identifier (`com.xxx.xxx`)
   - Version (ör. `1.0.0`)
   - Build (ör. `1`)
   - Team ID (Apple hesabındaki team)
5. Gerekli izinleri minimumda tut (çocuk oyunu olduğu için gereksiz permission ekleme).

## 4) Çocuk oyunu için kritik App Store kuralları

- Uygulama çocuklara yönelikse App Store'da yaş/kategori ayarlarını doğru seç.
- Gizlilik politikası linki zorunlu olmalı.
- Üçüncü parti reklam/analitik kullanıyorsan çocuk verisi kurallarını (COPPA/Kids) ihlal etmemelisin.
- Satın alma/harici link gibi alanlara "ebeveyn kapısı" koyman iyi olur.

## 5) Xcode ile archive alma

1. Godot'dan iOS export al.
2. Çıkan Xcode projesini aç.
3. `Signing & Capabilities` bölümünde doğru Team seç.
4. Gerçek cihazda bir kez çalıştırarak imzalama sorunlarını temizle.
5. `Product > Archive` ile arşiv al.
6. Organizer ekranından `Distribute App > App Store Connect > Upload` yap.

## 6) App Store Connect'te tamamlanacaklar

- Uygulama açıklaması (TR/EN)
- Anahtar kelimeler
- Ekran görüntüleri (iPhone boyutlarında)
- Uygulama ikonu
- Yaş derecelendirmesi
- Gizlilik bilgileri (Data Collection)

## 7) TestFlight önerisi (yayın öncesi)

- Önce TestFlight'a gönder.
- En az 5-10 test yap:
  - Oyun açılışı
  - Zıplama gecikmesi
  - Çarpışma doğruluğu
  - Reklam gösterimi varsa uygunluk

## 8) Yayın sırası (kısa özet)

1. Godot export ayarı
2. Xcode signing + archive
3. App Store Connect metadata
4. TestFlight
5. Review'a gönder

## Sık hata notları

- **Bundle ID uyuşmuyor:** Apple kaydı ile Godot/Xcode aynı olmalı.
- **Signing failed:** Team veya sertifika seçimi eksik.
- **Missing Compliance/Privacy:** App Store Connect'te bilgi alanları eksik.

Bu adımları tamamlayınca oyun App Store incelemesine gider.
