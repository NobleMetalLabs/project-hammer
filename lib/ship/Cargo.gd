class_name Cargo
extends RefCounted

var items : Array[CargoItem] = []
var _cargoitem_by_item : Dictionary = {} #[Item, CargoItem]
var capacity : int = 1000

func add_item(item : CargoItem) -> void:
	var existing_cargoitem : CargoItem = _cargoitem_by_item.get(item.item)
	if existing_cargoitem != null:
		if existing_cargoitem.quantity + item.quantity > capacity:
			print("Error: Trying to add more items than capacity")
			return
		existing_cargoitem.quantity += item.quantity
	else:
		items.append(item)
		_cargoitem_by_item[item.item] = item

func remove_item(item : CargoItem) -> void:
	var existing_cargoitem : CargoItem = _cargoitem_by_item.get(item.item)
	if existing_cargoitem != null:
		if existing_cargoitem.quantity < item.quantity:
			print("Error: Trying to remove more items than available")
			return
		existing_cargoitem.quantity -= item.quantity
		if existing_cargoitem.quantity == 0:
			items.erase(existing_cargoitem)
			_cargoitem_by_item.erase(item.item)

func _to_string() -> String:
	return "Cargo(%s)" % [", ".join(items.map(func(cargoitem : CargoItem) -> String: return str(cargoitem)))]
