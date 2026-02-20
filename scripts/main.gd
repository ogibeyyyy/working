extends Node2D

@export var obstacle_scene: PackedScene
@export var min_spawn_time: float = 1.0
@export var max_spawn_time: float = 1.8
@export var spawn_y: float = 460.0

@onready var player: CharacterBody2D = $Player
@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var score_label: Label = $CanvasLayer/HUD/ScoreLabel
@onready var status_label: Label = $CanvasLayer/HUD/StatusLabel
@onready var restart_button: Button = $CanvasLayer/HUD/RestartButton

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var score: int = 0
var game_over: bool = false

func _ready() -> void:
	rng.randomize()
	restart_button.pressed.connect(_on_restart_button_pressed)
	start_game()

func start_game() -> void:
	for child in get_children():
		if child.is_in_group("obstacles"):
			child.queue_free()

	score = 0
	game_over = false
	player.global_position = Vector2(180.0, spawn_y)
	player.alive = true
	player.velocity = Vector2.ZERO
	score_label.text = "Skor: 0"
	status_label.text = "Zıplamak için ekrana dokun!"
	restart_button.visible = false
	score_timer.start()
	_reset_spawn_timer()

func _reset_spawn_timer() -> void:
	spawn_timer.wait_time = rng.randf_range(min_spawn_time, max_spawn_time)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	if game_over:
		return

	var obstacle := obstacle_scene.instantiate() as Area2D
	obstacle.add_to_group("obstacles")
	obstacle.position = Vector2(980.0, spawn_y)
	obstacle.hit_player.connect(_on_player_hit)
	add_child(obstacle)
	_reset_spawn_timer()

func _on_score_timer_timeout() -> void:
	if game_over:
		return

	score += 1
	score_label.text = "Skor: %d" % score

func _on_player_hit() -> void:
	if game_over:
		return

	game_over = true
	player.die()
	spawn_timer.stop()
	score_timer.stop()
	status_label.text = "Oyun Bitti!"
	restart_button.visible = true

func _on_restart_button_pressed() -> void:
	start_game()
