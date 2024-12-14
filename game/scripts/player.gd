extends StaticBody2D

@export_group("Animation")
@export var IDLE_ANIMATION_SPEED_SCALE : float =  0.4
@export var THROW_ANIMATION_SPEED_SCALE : float = 3

var ducked := false 

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	idle()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("duck"):
		ducked = true
	else:
		ducked = false
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
	
func on_animation_finished() -> void:
	if sprite.animation == "throw":
		var snowball = load("res://scenes/snowball.tscn").instantiate()
		get_parent().add_child(snowball)
		snowball.position = position
		idle()
