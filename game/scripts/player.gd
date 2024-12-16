extends StaticBody2D

signal enemy_collision

@export_group("Animation")
@export var IDLE_ANIMATION_SPEED_SCALE : float =  0.4
@export var THROW_ANIMATION_SPEED_SCALE : float = 3
@export var DUCK_ANIMATION_SPEED_SCALE : float = 2
@export var STAND_UP_ANIMATION_SPEED_SCALE : float = 2

@export var sprite : AnimatedSprite2D


func _ready() -> void:
	assert(sprite)
	idle()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		throw()
	elif Input.is_action_pressed("duck") && sprite.animation == "idle":
		duck()
	elif Input.is_action_just_released("duck"):
		stand_up()

func throw() -> void:
	sprite.play("throw")
	sprite.speed_scale = THROW_ANIMATION_SPEED_SCALE

func idle() -> void:
		sprite.play("idle")
		sprite.speed_scale = IDLE_ANIMATION_SPEED_SCALE

func duck() -> void:
	sprite.play("duck")
	sprite.speed_scale = DUCK_ANIMATION_SPEED_SCALE

func stand_up() -> void:
	sprite.play("stand_up")
	sprite.speed_scale = STAND_UP_ANIMATION_SPEED_SCALE

func on_animation_finished() -> void:
	if sprite.animation == "throw":
		var snowball = load("res://scenes/snowball.tscn").instantiate()
		snowball.position = position + Vector2(-2, -4)
		get_parent().add_child(snowball)
		sprite.play("throw_return")
	elif sprite.animation == "stand_up":
		idle()
	elif sprite.animation == "throw_return":
		idle()
