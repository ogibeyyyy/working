extends Area2D

signal hit_player

@export var speed: float = 260.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -120.0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		hit_player.emit()
