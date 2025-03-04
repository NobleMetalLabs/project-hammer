class_name CargoItem
extends Resource

@export var item : ItemDB.Item
@export var quantity : int

func _init(item : ItemDB.Item, quantity : int) -> void:
	self.item = item
	self.quantity = quantity