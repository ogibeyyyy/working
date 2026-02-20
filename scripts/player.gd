extends CharacterBody2D

@export var gravity: float = 1600.0
@export var jump_force: float = -640.0
@export var max_fall_speed: float = 1200.0

var alive: bool = true

func _physics_process(delta: float) -> void:
	if not alive:
		velocity.x = 0.0
		velocity.y = min(velocity.y + gravity * delta, max_fall_speed)
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y = min(velocity.y + gravity * delta, max_fall_speed)

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

func die() -> void:
	alive = false
