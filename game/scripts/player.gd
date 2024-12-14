extends StaticBody2D

@export_group("Animation")
@export var IDLE_ANIMATION_SPEED_SCALE : float =  0.4
@export var THROW_ANIMATION_SPEED_SCALE : float = 3
@export var DUCK_ANIMATION_SPEED_SCALE : float = 2

var ducked := false 

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	idle()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("duck"):
		ducked = true
		duck()
	if event.is_action_released("duck"):
		ducked = false
		duck(true)
	if event.is_action_released("throw"):
		throw()

func on_hit() -> void:
	if not ducked:
		pass # get damage

func throw() -> void:
	sprite.play("throw")
	sprite.speed_scale = THROW_ANIMATION_SPEED_SCALE

func idle() -> void:
		sprite.play("idle")
		sprite.speed_scale = IDLE_ANIMATION_SPEED_SCALE

func duck(backwards: bool = false) -> void:
	if backwards:
		sprite.play_backwards("duck")
	else:
		sprite.play("duck")
	sprite.speed_scale = DUCK_ANIMATION_SPEED_SCALE
	
func on_animation_finished() -> void:
	if sprite.animation == "throw":
		var snowball = load("res://scenes/snowball.tscn").instantiate()
		get_parent().add_child(snowball)
		snowball.position = position
		idle()
	elif sprite.animation == "duck" and sprite.frame == 0:
		idle()
