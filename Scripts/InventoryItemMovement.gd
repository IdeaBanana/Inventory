extends Control

class_name Inventory

@export var inventory_array = preload("res://Resousrce/Inventory.tres").inventory_items

@onready var slots = $BoxContainer/GridContainer.get_children()
