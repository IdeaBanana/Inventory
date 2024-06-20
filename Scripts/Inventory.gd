extends Control

class_name Inventory

@onready var inventory_container = $InventoryContainer.get_children()

@export var inventory = preload("res://Resousrce/Inventory.tres").items

func _ready():
	var counter: int
	for integer in range(min(inventory_container.size(), inventory.size())):
		if inventory[integer] != null:
			inventory_container[integer].set_item(inventory[integer])
