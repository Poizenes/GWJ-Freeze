extends CharacterBody2D
class_name Snowball

@export var sound : AudioStreamPlayer2D

func _ready() -> void:
	velocity.x = get_parent().INITIAL_VELOCITY.x
	#velocity.y = get_parent().INITIAL_VELOCITY.y
	sound.play()

func _physics_process(delta: float) -> void:
	#velocity.y += get_parent().GRAVITY
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		collider.call("on_snowball_hit")
		get_parent().emit_signal("snowball_hit")
		queue_free()
