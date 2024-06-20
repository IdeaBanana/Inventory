extends Resource

class_name Item

# Абстрактный класс айтемов

enum Type {WEAPON, POTION, EAT, ARMOR, MAGE}

@export var type: Type
@export var item_name: String
@export var powerful: bool
@export var rarely: bool
@export var texture: Texture2D

func get_item_name() -> String:
	return item_name
func get_powerful() -> bool:
	return powerful
func get_rarely() -> bool:
	return rarely
func get_texture() -> ImageTexture:
	if !texture:
		return null
	if !texture is AtlasTexture:
		print(texture)
		return texture
	else:
		var image := Image.new()
		image = texture.get_image()
		var image_texture := ImageTexture.new()
		image_texture = image_texture.create_from_image(image)
		return image_texture
