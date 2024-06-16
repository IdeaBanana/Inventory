extends TextureRect

class_name SlotRect

@onready var panel: Panel = $Panel

var offset: Vector2

var item_texture: TextureRect = TextureRect.new()

var dragging: bool

func _on_child_entered_tree(node):
	if node is TextureRect:
		item_texture = node

func _get_drag_data(at_position: Vector2):
	
	var data = {}
	data["texture"] = texture
	
	var drag_preview := TextureRect.new()
	drag_preview.texture = data[]
	drag_preview.size = size

	add_child(drag_preview)
	return data

func _can_drop_data(at_position, data):
	var target
	return true

func _drop_data(at_position, data):
	pass
