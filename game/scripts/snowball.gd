extends CharacterBody2D
class_name Snowball

func _physics_process(delta: float) -> void:
	position.x += 100 * delta
