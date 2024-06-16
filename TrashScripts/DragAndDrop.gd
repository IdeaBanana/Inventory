extends Control

@onready var slots: Array = $GridContainer.get_children()
@onready var texture_spawner: TextureSpawner = $TextureSpawner

@export var inventory_array = preload("res://Resousrce/Inventory.tres").items_array

var current_item_from_button: ItemTextureButton

var item_taked: bool = false

var prev_mouse_position: Vector2
var distance_between_mouse_position: Vector2

func _ready():
	set_process(false)
	connect_all_Item()
	reset_current_values()
	
func connect_all_Item():
	for child in slots:
		if child is SlotUi:
			var child_slot = child
			child_slot.mouse_area_entered.connect(set_item_slot_position.bind(child_slot))
			for item in child_slot.get_children():
				if item is ItemTextureButton:
					var child_item_button = item
					child_item_button.button_down.connect(_on_item_pressed.bind(child_item_button))
					child_item_button.button_up.connect(_on_mouse_released)
			

func _on_item_pressed(item_rect: ItemTextureButton):
	current_item_from_button = item_rect
	set_process(true)
	prev_mouse_position = get_global_mouse_position()
	distance_between_mouse_position = get_offset_between(item_rect)
	item_taked = true
	
func _process(delta):
		move_and_drop(current_item_from_button)
	
func get_offset_between(item_rect: ItemTextureButton = current_item_from_button) -> Vector2:
	var offset = get_global_mouse_position() - item_rect.position
	return offset
	
func _on_mouse_released():
	reset_current_values()
	set_process(false)

func move_and_drop(item: ItemTextureButton = current_item_from_button):
	item.position = get_local_mouse_position() - distance_between_mouse_position

func reset_current_values():
	current_item_from_button = null

func set_item_slot_position(slot: SlotUi):
	if item_taked and current_item_from_button:
		if slot.get_mouse_in_area():
				for child in inventory_array:
					var curr_item = inventory_array[current_item_from_button.get_item_index()]
					if curr_item != child:
						child = curr_item
						child.get_item_name()
						inventory_array[current_item_from_button.get_item_index()] = null

func get_current_item_from_button() -> ItemTextureButton:
	return current_item_from_button

func get_current_index_item() -> int:
	return current_item_from_button.get_item_index()

func get_current_item() -> AbstractItem:
	return inventory_array.items_array[current_item_from_button.get_item_index()]
