extends GridContainer

class_name Slot

@onready var inventory = $"../.."

@export var current_item: AbstractItem = AbstractItem.new()

@export var frames: Vector2 = Vector2(18, 18)
func _ready():
	find_slots()
	
func find_slots():
	for index in range(get_children().size()):
		set_child_texture(inventory.invenotory_array[index], get_child(index))

func set_child_texture(item: AbstractItem, slot: SlotRect):
	var item_rect: TextureRect = TextureRect.new()
	item_rect.z_index = 2
	if item:
		var texture_from_item : Texture2D = item.get_texture()
		item_rect.texture = texture_from_item
		item_rect.size = slot.size
		slot.add_child(item_rect)
