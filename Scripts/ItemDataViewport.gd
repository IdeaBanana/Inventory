extends VBoxContainer

@onready var inventory = $"../.."

@onready var visual = $VisualItem
@onready var item_text = $ItemLabel
@onready var type_text = $TypeLabel
@onready var powerful_text = $PowerfulLabel
@onready var rarely_text = $RarelyLabel

@export_group("Prefixes")
@export var prefix_item: String
@export var prefix_type: String
@export var prefix_rarely: String
@export var prefix_powerful: String

@export_group("Labels")
@export var label_unknown_item: String
@export var label_true_bool: String
@export var label_false_bool: String

func _ready():
	update_item_data()
	visual.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	inventory.item_selected.connect(update_item_data)
	inventory.item_removed.connect(update_item_data)

func update_item_data():
	var item: Item = inventory.get_currently_item()
	if item:
		visual.texture = item.get_texture()
		item_text.text = prefix_item + item.get_item_name()
		type_text.text = prefix_type + item.get_type()
		if item.get_powerful():
			powerful_text.text = prefix_powerful + label_true_bool
		else:
			powerful_text.text = prefix_powerful + label_false_bool
		if item.get_rarely():
			rarely_text.text = prefix_rarely + label_true_bool
		else:
			rarely_text.text = prefix_rarely + label_false_bool
	else:
		visual.texture = null
		item_text.text = prefix_item + label_unknown_item
		type_text.text = prefix_type + label_unknown_item
		powerful_text.text = prefix_powerful + label_unknown_item
		rarely_text.text = prefix_rarely + label_unknown_item
		
