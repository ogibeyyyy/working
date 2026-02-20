# Zıplayan Dino (Godot 4)

Bu depo, çocuklara uygun basit bir 2D runner oyununun çalışır bir Godot projesini içerir.

## Dosyaları nasıl indireceğim?

### Yöntem 1) GitHub'dan ZIP indir (en kolay)

1. Bu projenin GitHub sayfasına gir.
2. `Code` butonuna bas.
3. `Download ZIP` seç.
4. ZIP'i çıkart.
5. Godot'da `Import` deyip çıkarttığın klasördeki `project.godot` dosyasını seç.

### Yöntem 2) Git ile indir

```bash
git clone <repo-url>
cd <repo-klasoru>
```

Sonra Godot'da `Import` ile `project.godot` dosyasını aç.

## Çok önemli: Dosyaları tek tek oluşturman gerekmiyor

- `scenes/` ve `scripts/` içindeki dosyalar zaten projenin parçası.
- Bunları Godot içinde tek tek yeniden yazmana gerek yok.
- Sadece proje klasörünü (`project.godot` olan klasör) import etmen yeterli.

## Çalıştırma

1. Godot 4.2+ aç.
2. `Import` de.
3. Bu klasördeki `project.godot` dosyasını seç.
4. Projeyi aç.
5. `F5` ile oyunu başlat.

## Import ekranında dosyalar görünmüyorsa

- Yanlış klasörde olabilirsin. `project.godot` görünen klasörü seç.
- Godot filtresi nedeniyle yalnızca proje dosyası listelenebilir; bu normal.
- Proje açıldıktan sonra `FileSystem` panelinde `scenes/` ve `scripts/` görünür.

## Kontroller

- `Space`
- Sol tık
- Mobilde ekrana dokun

## Proje İçeriği

- `project.godot`: Proje ayarları ve input map
- `scenes/Main.tscn`: Oyun akışı, HUD, timer bağlantıları
- `scenes/Player.tscn`: Oyuncu sahnesi
- `scenes/Obstacle.tscn`: Engel sahnesi
- `scripts/*.gd`: Oyun mantığı

## Not

Bu sürüm MVP odaklıdır: tek tuş zıplama, skor, çarpışma, tekrar başlatma.
