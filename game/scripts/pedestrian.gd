extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var collision_shape : CollisionShape2D
@export var sound: AudioStreamPlayer2D

func _ready() -> void:
	assert(sprite)
	assert(collision_shape)
	sprite.play("walk")
	velocity.x = -10

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func on_snowball_hit() -> void:
	collision_shape.disabled = true
	sprite.play("hit")
	sprite.flip_h = true
	sound.play()

func _on_animation_finished() -> void:
	if sprite.animation == "hit":
		queue_free()
