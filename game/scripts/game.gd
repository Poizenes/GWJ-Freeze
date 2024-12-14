extends Node2D

@export_group("Snowball Physics")
@export var GRAVITY := 1.5
@export var INITIAL_VELOCITY := Vector2(160, -75)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
