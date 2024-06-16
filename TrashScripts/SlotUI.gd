extends Panel

class_name SlotUi
@onready var slot_background: TextureRect = $SlotBackground

@export var area: Rect2 
@export var area_position: Vector2
@export var area_size: Vector2

var mouse_enter: bool

signal mouse_area_entered

var mouse_in_area: bool = false

func _physics_process(delta):
	check_mouse_position_area()

func check_mouse_position_area():
	if get_global_rect().has_point(get_global_mouse_position()):
		if not mouse_in_area:
			mouse_in_area = true
			emit_signal("mouse_area_entered")
		return true
	else:
		if mouse_in_area:
			mouse_in_area = false
		return false
	
func get_mouse_in_area():
	return mouse_in_area
