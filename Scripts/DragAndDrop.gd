extends TextureRect

class_name SlotRect


@onready var inventory = $"../../..".inventory_array

@export var taked_modulate: Color = Color("d5d5d5")

var offset: Vector2
var item_texture := ItemVisual.new()
var dragging: bool

var data = {}
var data_item := "item"
var data_preview_rect := "data preview rect"

var released := false

func _on_child_entered_tree(node):
	if node is ItemVisual:
		item_texture = node

func _get_drag_data(at_position: Vector2):
	data[data_item] = item_texture.get_self_item()
	
	var drag_rect_preview := TextureRect.new()
	drag_rect_preview.texture = item_texture.texture
	drag_rect_preview.size = item_texture.size
	drag_rect_preview.z_index = item_texture.z_index
	drag_rect_preview.modulate = taked_modulate
	data[data_preview_rect] = drag_rect_preview
	add_child(data[data_preview_rect])
	
	return data

func _can_drop_data(at_position, data):
	set_process_input(true)
	if !released:
		data[data_preview_rect].position = at_position - data[data_preview_rect].size / 2
		return true

func _drop_data(at_position, data):
	var new_parent := slot_on_mouse_position()
	
	if new_parent:
		var filtered_child := new_parent.get_children().filter(func(child): return child is ItemVisual or child == item_texture)
		if !filtered_child:
			print(filtered_child)
			item_texture.set_global_position(new_parent.global_position)
			item_texture.reparent(new_parent)
	released = true
	if released:
		var rect = data[data_preview_rect]
		rect.queue_free()
		data.erase([data_preview_rect])

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				released = false
				set_process_input(false)

func slot_on_mouse_position() -> SlotRect:
	var children := get_parent().get_children()
	var child_in_children := children.filter(func(child): return child.get_global_rect().has_point(get_global_mouse_position()) and child != self)
	if child_in_children:
		if child_in_children.size() == 1:
			var child = child_in_children[0]
			return child
	return null

func get_item_texture() ->ItemVisual:
	return item_texture
