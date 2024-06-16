extends MarginContainer

@export var margin_percent: float
@export var start_margin_constant = 18.0

@export var slot_item_position: Vector2

var start_size: Vector2

var new_const: float

func _ready():
	resized.connect(change_margin_constants.bind(get_margin_percent()))
	
func get_margin_percent() -> float:
	margin_percent = snapped(start_margin_constant / 100, 0.01)
	return margin_percent
	
func change_margin_constants(percent: float):
	new_const = size.x * percent
	var int_new_const = int(new_const)
	add_theme_constant_override("margin_left", int_new_const)
	add_theme_constant_override("margin_top", int_new_const)
	add_theme_constant_override("margin_right", int_new_const)
	add_theme_constant_override("margin_bottom", int_new_const)
