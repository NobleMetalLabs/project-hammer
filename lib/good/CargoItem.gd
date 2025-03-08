class_name CargoItem
extends Resource

@export var item : ItemDB.Item
@export var quantity : int

func _init(item : ItemDB.Item, quantity : int) -> void:
	self.item = item
	self.quantity = quantity

func _to_string() -> String:
	return "CargoItem(%s, %s)" % [ItemDB.item_string(item), quantity]