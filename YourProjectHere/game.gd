extends Node

@onready
var input_position : Vector2 = get_viewport().get_visible_rect().size / 2

@export
var circle_speed_rate : Curve 
@export
var circle_ms =  .1
@export
var circle_velocity : Vector2 = Vector2.ZERO

func _ready() -> void:
	CrispGDInput.input_pressed.connect(on_input_pressed)
	CrispGDInput.input_just_pressed.connect(on_input_just_pressed)
	CrispGDInput.input_released.connect(on_input_just_released)
	
	
	
func _physics_process(delta: float) -> void:
	%InputPosition.position = input_position
	var distance_to_input : float =  min(1,(%InputPosition.position-%BeeCirclePosition.position).length()/50)
	circle_velocity += (%InputPosition.position-%BeeCirclePosition.position).normalized() * circle_speed_rate.sample(distance_to_input) * circle_ms
	
	%BeeCirclePosition.position += circle_velocity
	
	
func on_input_pressed(pos,delta)->void:
	input_position = pos
	pass
	
func on_input_just_pressed(pos,delta)->void:
	input_position = pos
	pass
	
func on_input_just_released(pos,delta)->void:
	pass
