extends GridContainer

class_name Slot

@onready var inventory = $"../.."

@export var current_item := AbstractItem.new()

@export var size_item: Vector2 = Vector2(37.6, 37.6)
func _ready():
	find_slots()
	
func find_slots():
	for index in range(get_children().size()):
		set_child_texture(inventory.inventory_array[index], get_child(index))

func set_child_texture(item: AbstractItem, slot: SlotRect):
	var item_rect := ItemVisual.new()
	if item:
		var texture_from_item : Texture2D = item.get_texture()
		item_rect.texture = texture_from_item
		slot.add_child(item_rect)

func set_current_item(new_item: AbstractItem):
	current_item = new_item

func get_current_item() -> AbstractItem:
	return current_item
