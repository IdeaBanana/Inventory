extends TextureRect

class_name ItemSlot

@onready var inventory = $"../.."
@onready var inventory_container = $"..".get_children()

@export var frames: Vector2
@onready var slot_7 := $"../Slot7"

var item

var data := {}
var data_item := "Slot"
var data_previous_slot := "PrevSlot"

func _get_drag_data(at_position):
	data[data_item] = item
	data[data_previous_slot] = self
	return data

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	var filtered_slot: Array = inventory_container.filter(func(child): return child.get_global_rect().has_point(get_global_mouse_position()))
	if filtered_slot[0]:
		var slot = filtered_slot[0]
		if slot in inventory_container:
			if !slot.get_item():
				slot.set_item(data[data_item])
				data[data_previous_slot].set_item(null)

func get_item() -> Item:
	return item

func set_item(new_item: Item):
	item = new_item
	update_item()

func update_item():
	if item:
		var new_texture = item.get_texture()
		new_texture.set_size_override(size)
		texture = new_texture
	else:
		texture = null
