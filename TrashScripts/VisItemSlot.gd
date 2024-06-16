extends Panel

class_name InventorySlotUI

@onready var inventory = $"../../../../.."
@onready var item_visual = $ItemMargin/Item
@onready var ui_slots: Array = $"..".get_children()

var collector: InventoryItemsCollector = preload("res://Resources/Inventory/Items/Collector.tres")

var item_resource: AbstractItem

func _ready():
	if item_visual is TextureRect:
		item_visual.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		item_visual.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	for slot in range(min(ui_slots.size(), collector.items_array.size())):
		ui_slots[slot].update_texture(collector.items_array[slot])

func update_texture(item: AbstractItem):
	if item != null and item_visual:
		item_resource = item
		if item.get_texture() is AtlasTexture:
			var image = extract_image_from_atlas(item)
			if image:
				var image_texture: ImageTexture =  create_image_texture(image)
				
				item_visual.texture = image_texture
		else:
			item_visual.texture = item.get_texture()

func extract_image_from_atlas(item: AbstractItem) -> Image:
	var new_atlas: AtlasTexture = item.get_texture()
	var new_image: Image = new_atlas.get_image()
	return new_image

func create_image_texture(img: Image) -> ImageTexture:
	var texture_image: ImageTexture = ImageTexture.new()
	var new_texture
	new_texture = texture_image.create_from_image(img)
	return new_texture

func get_item_texture() -> TextureRect:
	return item_visual

func get_item_resource() -> AbstractItem:
	return item_resource

