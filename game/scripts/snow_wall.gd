extends StaticBody2D

@export var sprite: AnimatedSprite2D
@export var hitbox: CollisionShape2D

@export var states: Array = [66, 33, 0]
var current_state = 0
@export var max_health: int = 100
var health: int = max_health:
	set(new_health):
		print("Health")
		if new_health > 0:
			health = new_health
		else:
			health = 0
			hitbox.disabled = true
		if current_state < states.size() and health <= states[current_state]:
			sprite.frame += 1
			current_state += 1
