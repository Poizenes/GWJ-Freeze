extends CharacterBody2D


@export var sprite : AnimatedSprite2D
@export var collision_shape : CollisionShape2D

func _ready() -> void:
	assert(sprite)
	assert(collision_shape)
	sprite.play("walk")

func _physics_process(delta: float) -> void:
	position.x -= 10 * delta

func on_snowball_hit() -> void:
	collision_shape.disabled = true
	sprite.play("hit")


func _on_animation_finished() -> void:
	if sprite.animation == "hit":
		queue_free()
