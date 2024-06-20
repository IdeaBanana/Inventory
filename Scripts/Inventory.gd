extends Control

class_name Inventory

@onready var inventory_container = $InventoryContainer.get_children()

# наш инвентарь
@export var inventory = preload("res://Resousrce/Inventory.tres").items

func _ready():
	var counter: int
# на случай если слотов будет где-то меньше
	for integer in range(min(inventory_container.size(), inventory.size())):
		if inventory[integer] != null:
			inventory_container[integer].set_item(inventory[integer])


func inventory_change_item(prev_slot_index: int, new_slot_index: int):
# заменяем новое значание = null на старое т.е. айтем
	inventory[new_slot_index] = inventory[prev_slot_index]
	inventory[prev_slot_index] = null
