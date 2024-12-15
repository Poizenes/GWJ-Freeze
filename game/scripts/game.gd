class_name Game extends Node2D

signal snowball_hit

@export_group("Snowball Physics")
@export var GRAVITY := 1.5
@export var INITIAL_VELOCITY := Vector2(160, -75)

@export_group("Pedestrians")
@export var pedestrian_spawn_timer: Timer
@export var score_counter: Label

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
	add_child(pedestrian)
	pedestrian_queue.append(pedestrian)
	print("Pedestrian spawned")

func on_snowball_hit():
	score += 1
