class_name Game extends Node2D

@warning_ignore("unused_signal")
signal snowball_hit

@export var score_counter: Label
@export_group("Snowball Physics")
@export var GRAVITY := 1.5
@export var INITIAL_VELOCITY := Vector2(160, -75)
@export_group("Pedestrians")
@export var pedestrian_spawn_timer: Timer
@export var pedestrian_speed: float = 10
@export var pedestrian_acceleration: float = 1.1
@export var pedestrian_spawn_delay_multiplier: float = 0.9

var pedestrian_queue: Array = []

var score : int = 0:
	set(new_score):
		score = new_score
		score_counter.text = str(score)

func _ready() -> void:
	assert(pedestrian_spawn_timer)
	assert(score_counter)
	pedestrian_spawn_timer.connect("timeout", spawn_pedestrian)
	connect("snowball_hit", on_snowball_hit)
	
	score = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func spawn_pedestrian():
	var pedestrian = load("res://scenes/pedestrian.tscn").instantiate()
	pedestrian.position = Vector2(310, 130)
	pedestrian.velocity.x = -pedestrian_speed
	pedestrian_speed *= pedestrian_acceleration
	pedestrian_spawn_timer.wait_time *= pedestrian_spawn_delay_multiplier
	add_child(pedestrian)
	pedestrian_queue.append(pedestrian)

func on_snowball_hit():
	score += 1
