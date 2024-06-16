extends Control

class_name TextureSpawner

@onready var slots: Array = $"../GridContainer".get_children()

@export var frames_for_item: float = 18.0

var collector_item: InventoryArray = preload("res://Resousrce/Inventory.tres")

func _ready():
	set_textures()
	
func set_textures():
	for quantity in range(min(collector_item.items_array.size(), slots.size())):
		var visual_item: ItemTextureButton = ItemTextureButton.new()
		add_new_texture(visual_item, slots[quantity], collector_item.items_array[quantity])

func add_new_texture(visual_item: ItemTextureButton, slot, item: AbstractItem, new_item: bool = true):
	if new_item:
		if item:
			if slot.size.x == slot.size.y:
				visual_item.size = slot.size - count_square_frames()
			if slot.pivot_offset == Vector2.ZERO:
				visual_item.position = get_item_slot_position()
				
			if item.get_texture() is AtlasTexture:
				var img = extract_image_from_atlas(item)
				if img:
					var img_texture = create_image_texture(img)
					
					img_texture.set_size_override(visual_item.size)
					visual_item.texture_normal = img_texture
			else:
				item.get_texture().set_size_override(visual_item.size)
				visual_item.texture_normal = item.get_texture()
				
			visual_item.name = item.get_item_name()
			visual_item.z_index = 2 
			
			visual_item.set_item(item)
			slot.add_child(visual_item)
	
func delete_texture():
	pass

func extract_image_from_atlas(item: AbstractItem) -> Image:
	var new_atlas: AtlasTexture = item.get_texture()
	var new_image: Image = new_atlas.get_image()
	return new_image

func create_image_texture(img: Image) -> ImageTexture:
	var texture_image: ImageTexture = ImageTexture.new()
	var new_texture: ImageTexture = texture_image.create_from_image(img)
	return new_texture

func count_square_frames() -> Vector2:
	return Vector2(frames_for_item, frames_for_item) * 2

func get_item_slot_position() -> Vector2:
	var null_position: Vector2 = Vector2.ZERO
	var position_in_slot = null_position + count_square_frames() / 2 
	return position_in_slot

