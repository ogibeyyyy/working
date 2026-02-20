# Godot ile Çocuklara Yönelik Basit iOS Oyunu (Hızlı Başlangıç)

Bu rehber, **ücretsiz araçlarla** hızlıca bir prototip çıkarmak için hazırlandı.
Hedef oyun: **tek dokunuşla zıplama** mantığında basit 2D runner.

## 1) Kurulum

1. Godot 4.x indir ve kur.
2. "New Project" oluştur:
   - Project Name: `ZiplayanDino`
   - Renderer: `Forward+` (2D için sorun olmaz)
3. `Project Settings > Input Map` içinde aksiyon ekle:
   - `jump` (Space ve Mouse Left)

## 2) Klasör Yapısı

Aşağıdaki gibi sade bir yapı yeterli:

- `scenes/`
  - `Main.tscn`
  - `Player.tscn`
  - `Obstacle.tscn`
- `scripts/`
  - `player.gd`
  - `main.gd`
  - `obstacle.gd`
- `ui/`
  - `HUD.tscn`

## 3) Sahne Kurulumu

### Player.tscn
- Kök: `CharacterBody2D`
- Çocuklar:
  - `Sprite2D`
  - `CollisionShape2D`

`player.gd`:

```gdscript
extends CharacterBody2D

@export var gravity: float = 1200.0
@export var jump_force: float = -420.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
```

### Obstacle.tscn
- Kök: `Area2D`
- Çocuklar:
  - `Sprite2D`
  - `CollisionShape2D`

`obstacle.gd`:

```gdscript
extends Area2D

@export var speed: float = 220.0

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -100:
		queue_free()
```

### Main.tscn
- Kök: `Node2D`
- Çocuklar:
  - `Player` (instance)
  - `ObstacleSpawner` (`Node2D`)
  - `SpawnTimer` (`Timer`)
  - `ScoreTimer` (`Timer`)
  - `CanvasLayer/HUD` (Label + Butonlar)

`main.gd`:

```gdscript
extends Node2D

@export var obstacle_scene: PackedScene
@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var score_label: Label = $CanvasLayer/HUD/ScoreLabel

var score: int = 0
var game_over: bool = false

func _ready() -> void:
	spawn_timer.start()
	score_timer.start()

func _on_spawn_timer_timeout() -> void:
	if game_over:
		return
	var obs = obstacle_scene.instantiate()
	obs.position = Vector2(900, 500)
	obs.body_entered.connect(_on_player_hit)
	add_child(obs)

func _on_score_timer_timeout() -> void:
	if game_over:
		return
	score += 1
	score_label.text = "Skor: %d" % score

func _on_player_hit(_body: Node) -> void:
	game_over = true
	spawn_timer.stop()
	score_timer.stop()
```

> Not: `Obstacle` kökünü `Area2D` yerine `StaticBody2D` yapmak istersen çarpışma sinyalini ona göre güncelle.

## 4) Çocuk Oyunlarında Güvenli Tasarım

- Şiddet içermeyen görseller kullan.
- Büyük ve net butonlar kullan.
- Reklam tetiklerini seyrek tut (ör. 3 oyunda 1).
- "Ebeveyn kapısı" ekle (ayarlar/satın alma ekranı öncesi basit soru).

## 5) Reklam Entegrasyonu (İlk Aşama)

- Önce oyun döngüsünü bitir.
- Sonra iOS reklam SDK'sı ekle (test reklamlarıyla).
- Kişisel veri toplamadan çalışan ayarları tercih et.
- Kids odaklı kategori için App Store kurallarını yayın öncesi kontrol et.

## 6) iOS Yayına Hazırlık Checklist

- [ ] Apple Developer hesabı aktif
- [ ] Uygulama ikonu ve ekran görüntüleri hazır
- [ ] Gizlilik politikası linki hazır
- [ ] TestFlight'ta minimum 5-10 test oturumu yapıldı
- [ ] Çökme/bug kontrolü tamamlandı

## 7) 7 Günlük Hızlı MVP Planı

- Gün 1: Hareket ve zıplama
- Gün 2: Engel spawn + çarpışma
- Gün 3: Skor + game over
- Gün 4: Basit UI + ses
- Gün 5: Denge ve zorluk ayarı
- Gün 6: iOS build ve test
- Gün 7: Store materyalleri ve gönderim

Bu planla ilk sürümü hızlıca çıkarıp, sonrasında yeni karakterler ve kozmetiklerle güncelleme yapabilirsin.
