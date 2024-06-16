extends TextureButton

class_name ItemTextureButton

@export var self_item_index: int

var self_area_rect: Rect2
var self_area_position: Vector2
var self_area_size: Vector2

@export var inventory = preload("res://Resousrce/Inventory.tres")

signal mouse_area_entered
signal mouse_area_exited

func set_item(item: AbstractItem):
	for other_item in inventory.items_array:
		if item != other_item:
			self_item_index += 1
		if item == other_item:
			return

func get_item_index() -> int:
	return self_item_index

