extends Node2D

signal input_just_pressed(position: Vector2, delta: float)
signal input_pressed(position: Vector2, delta: float)
signal input_released(position: Vector2, delta: float)



func _process(_delta):
	var mouse_pos = get_clamped_mouse_position()
	if Input.is_action_just_pressed("game_pressed"):
		input_just_pressed.emit(mouse_pos, _delta)
	elif Input.is_action_pressed("game_pressed"):
		input_pressed.emit(mouse_pos, _delta)
	elif Input.is_action_just_released("game_pressed"):
		input_released.emit(mouse_pos, _delta)

func get_clamped_mouse_position() -> Vector2:
	var raw_pos = get_global_mouse_position()
	var viewport_size = get_viewport_rect().size
	return Vector2(
		clamp(raw_pos.x, 0, viewport_size.x),
		clamp(raw_pos.y, 0, viewport_size.y)
		)
