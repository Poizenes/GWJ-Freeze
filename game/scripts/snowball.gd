extends CharacterBody2D
class_name Snowball

@export var sound : AudioStreamPlayer2D

@onready var start_position: Vector2

func _ready() -> void:
	sound.play()
	start_position = global_position

var t = 0
func fly_arc(p0: Vector2, p2: Vector2, stretch: float, delta: float, speed: float = 1) -> void:
	t += delta * speed
	var p1 = Vector2(0.5 * (p0.x + p2.x), 0.5 * (p0.y + p2.y) + stretch)
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	position = q0.lerp(q1, t)

func _physics_process(delta: float) -> void:
	var pedestrian_pos = get_nearest_pedestrian_position(Vector2(160, 120))
	fly_arc(start_position, pedestrian_pos, -100, delta)
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("on_snowball_hit"):
			collider.call("on_snowball_hit")
			get_parent().emit_signal("snowball_hit")
		queue_free()

var nearest_pedestrian_position: Vector2 = Vector2.ZERO:
	set(new_position):
		nearest_pedestrian_position = new_position
	get:
		return nearest_pedestrian_position

func get_nearest_pedestrian_position(fallback: Vector2 = Vector2.ZERO) -> Vector2:
	if nearest_pedestrian_position:
		return nearest_pedestrian_position
	elif not get_parent().pedestrian_queue.is_empty():
		var pedestrian = get_parent().pedestrian_queue.pop_front()
		if pedestrian:
			nearest_pedestrian_position = Vector2(pedestrian.position)
	else:
		nearest_pedestrian_position = fallback
	return nearest_pedestrian_position
