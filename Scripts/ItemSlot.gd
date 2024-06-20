extends TextureRect

class_name ItemSlot

@onready var inventory = $"../.."
@onready var inventory_container = $"..".get_children()

@export var frames: Vector2

var item
# тут я схитрил, data это отдельный словарь, который хранит перемещаемые объекты
var data := {}
var data_item := "Slot"
var data_previous_slot := "PrevSlot"

# получаем перемещаемые объекты
func _get_drag_data(at_position):
	data[data_item] = item
	data[data_previous_slot] = self
	return data
	
# Пишем условия при котором можно отпускать data
func _can_drop_data(at_position, data):
	return true

# отпускаем data
func _drop_data(at_position, data):
#Отсеиваем ненужные элементы
	var filtered_slot: Array = inventory_container.filter(func(child): return child.get_global_rect().has_point(get_global_mouse_position()))
	if filtered_slot[0]:
		var slot = filtered_slot[0]
		if slot in inventory_container:
			if !slot.get_item():
#Меняем слоты
				slot.set_item(data[data_item])
				data[data_previous_slot].set_item(null)
#Меняем индексы в массиве
				var filtered_slot_index := inventory_container.find(slot)
				var prev_slot_index := inventory_container.find(data[data_previous_slot])
				inventory.inventory_change_item(prev_slot_index, filtered_slot_index)

#Для удобства и чтобы использовать в других скриптах
func get_item() -> Item:
	return item

# для замены айтема, допустим при создании инвентаря
func set_item(new_item: Item):
	item = new_item
	update_item()

# меняем текстуру
func update_item():
	if item:
		var new_texture = item.get_texture()
		new_texture.set_size_override(size)
		texture = new_texture
	else:
		texture = null
