extends CharacterBody2D
class_name Snowball

func _ready() -> void:
	velocity.x = get_parent().INITIAL_VELOCITY.x
	velocity.y = get_parent().INITIAL_VELOCITY.y
	pass

func _physics_process(delta: float) -> void:
	velocity.y += get_parent().GRAVITY
	move_and_slide()
