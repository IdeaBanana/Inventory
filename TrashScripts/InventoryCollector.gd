extends Control

@export var inventory: InventoryItemsCollector

var open: bool = false

func _ready():
	if !open:
		open_inventory()
		
func close_inventory():
	open = false
	self.hide()
	
func open_inventory():
	open = true
	self.show()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_inventory"):
			if !get_open_mode():
				open_inventory()
			else:
				close_inventory()
			
func get_open_mode() -> bool:
	return open
