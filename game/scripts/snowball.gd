extends CharacterBody2D
class_name Snowball

@export var sound : AudioStreamPlayer2D
var GRAVITY = 150
var HORIZONTAL_SPEED = -20000

@onready var start_position: Vector2

var nearest_pedestrian_position: Vector2 = Vector2.ZERO:
	set(new_position):
		nearest_pedestrian_position = new_position
	get:
		return nearest_pedestrian_position

func _ready() -> void:
	sound.play()
	start_position = global_position
	var pedestrian_pos = get_nearest_pedestrian_position(Vector2(160, 120))
	var range = pedestrian_pos.x - position.x
	var angle = atan((range * GRAVITY)/(2 * HORIZONTAL_SPEED))
	var initial_velocity = get_initial_velocity(range, angle)
	velocity.x = initial_velocity * cos(angle)
	velocity.y = initial_velocity * sin(angle)

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider is Pedestrian:
			collider.on_snowball_hit()
		queue_free()

func get_nearest_pedestrian_position(fallback: Vector2 = Vector2.ZERO) -> Vector2:
	if nearest_pedestrian_position:
		return nearest_pedestrian_position
	elif not get_parent().pedestrian_queue.is_empty():
		var pedestrian: Pedestrian = get_parent().pedestrian_queue.pop_front()
		if pedestrian:
			nearest_pedestrian_position = Vector2(pedestrian.position)
			nearest_pedestrian_position.x += pedestrian.velocity.x
	else:
		nearest_pedestrian_position = fallback
	return nearest_pedestrian_position
	
	
func get_initial_velocity(range, angle = 0.8) -> float:
	return sqrt((range * -GRAVITY)/(sin(2 * angle)))
