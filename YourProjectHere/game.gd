extends Node2D
class_name Game

class Entity:
	var position : Vector2
	var size : float
	var velocity : Vector2 = Vector2.ZERO
	func _init(_position: Vector2, _size : float) -> void:
		position=_position
		size=_size
		

@onready
var input_position : Vector2 = get_viewport().get_visible_rect().size / 2
@export
var circle_size = 100
@export
var circle_ms =  4
@export
var circle_velocity : Vector2 = Vector2.ZERO
@export
var circle_drag = .5

var bees : Array[Entity] = []

var enemies : Array[Entity] = []

func _ready() -> void:
	CrispGDInput.input_pressed.connect(on_input_pressed)
	CrispGDInput.input_just_pressed.connect(on_input_just_pressed)
	CrispGDInput.input_released.connect(on_input_just_released)
	
	
	
func _physics_process(delta: float) -> void:
	%InputPosition.position = lerp(%InputPosition.position,input_position, 5 * delta)
	circle_velocity += (%InputPosition.position-%BeeCirclePosition.position).normalized() * circle_ms * delta
	circle_velocity = lerp(circle_velocity,Vector2.ZERO, circle_drag * delta)
	%BeeCirclePosition.position += circle_velocity
	
	for bee : Entity in bees:
		
		if bee.position.distance_squared_to(%BeeCirclePosition.position) < circle_size*circle_size:
			bee.velocity = lerp(bee.velocity,Vector2(randf_range(-5,5),randf_range(-5,5)),.05)
			bee.velocity = lerp(bee.velocity,circle_velocity,.1)
		else:
			bee.velocity += (%BeeCirclePosition.position-bee.position).normalized() * 3 * delta
		bee.position += bee.velocity
		
	
	queue_redraw()
	
	
func _draw() -> void:
	for entity : Entity in bees:
		draw_circle(entity.position,entity.size,Color.YELLOW,false,3)
	for entity : Entity in enemies:
		draw_circle(entity.position,entity.size,Color.RED,false,3)
	draw_circle(%BeeCirclePosition.position,circle_size,Color.SEA_GREEN,false,4)
	
func on_input_pressed(pos,delta)->void:
	input_position = pos
	pass
	
func on_input_just_pressed(pos,delta)->void:
	input_position = pos
	pass
	
func on_input_just_released(pos,delta)->void:
	pass


func _on_bee_spawner_timeout() -> void:
	bees.append(Entity.new(Vector2(randf_range(0,get_viewport().get_visible_rect().size.x)
		,randf_range(0,get_viewport().get_visible_rect().size.y)),randf_range(5,15)))
	


func _on_enemy_spawner_timeout() -> void:
	pass # Replace with function body.
