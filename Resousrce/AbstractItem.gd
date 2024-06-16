extends Resource

class_name AbstractItem

@export var name: String
@export var powerful: bool
@export var rarely: bool
@export var texture: Texture2D


func get_item_name() -> String:
	return name

func get_powerful() -> bool:
	return powerful

func get_rarely() -> bool:
	return rarely

func get_texture() -> Texture2D:
	if texture is AtlasTexture:
		var image := Image.new()
		image = texture.get_image()
		var image_texture := ImageTexture.new()
		image_texture = image_texture.create_from_image(image)
		return image_texture
	else:
		return texture
