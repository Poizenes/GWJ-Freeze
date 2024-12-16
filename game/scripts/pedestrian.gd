class_name Pedestrian extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var collision_shape : CollisionShape2D
@export var sound: AudioStreamPlayer2D
@export var HIT_ANIMATION_SPEED_SCALE: float = 3
@export var DAMAGE: int = 10

func _ready() -> void:
	assert(sprite)
	assert(collision_shape)
	sprite.play("walk")

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("wall"):
				collision_shape.disabled = true
				sprite.play("hit")
				velocity.x = 0
				sprite.speed_scale = HIT_ANIMATION_SPEED_SCALE
				collider.health -= DAMAGE
				get_parent().pedestrian_queue.pop_front()
		elif collider.is_in_group("player"):
			collider.emit_signal("enemy_collision")
	
	
func on_snowball_hit() -> void:
	collision_shape.disabled = true
	sprite.play("hit")
	velocity.x = 0
	sprite.speed_scale = HIT_ANIMATION_SPEED_SCALE
	sound.play()
	get_parent().emit_signal("snowball_hit")

func _on_animation_finished() -> void:
	if sprite.animation == "hit":
		queue_free()
