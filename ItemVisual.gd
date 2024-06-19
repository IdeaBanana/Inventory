extends TextureRect

class_name ItemVisual

var index_z := 2

@export var self_item := AbstractItem.new()

@export var custom_size: Vector2 = Vector2(37.6, 37.6)

func _ready():
	z_index = index_z
	size = custom_size

func set_self_item(new_item: AbstractItem):
	self_item = new_item

func get_self_item() -> AbstractItem:
	return self_item
