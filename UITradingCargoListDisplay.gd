class_name UITradingCargoListDisplay
extends PanelContainer


@onready var item_row : UITradingCargoListItemRow = self.find_child("ITEM-ROW", true, false)

var _shown_cargo : Cargo
var _current_rows : Array[UITradingCargoListItemRow] = []
var _current_cargo_modifications : Dictionary = {} #[Item, CargoItem]

func _ready():
	item_row.hide()

signal trade_changed()

func set_cargo(cargo : Cargo) -> void:
	_current_cargo_modifications.clear()
	_shown_cargo = cargo
	for row in _current_rows:
		row.queue_free()
	_current_rows.clear()
	for item in _shown_cargo.items:
		var row : UITradingCargoListItemRow = item_row.duplicate()
		item_row.add_sibling(row)
		row.item_count_changed.connect(
			func(cargo_item : CargoItem) -> void:
				trade_changed.emit()
				if cargo_item.quantity == 0:
					_current_cargo_modifications.erase(cargo_item.item)
					return
				_current_cargo_modifications[cargo_item.item] = cargo_item
		)
		row.set_item_row_data(item)
		row.show()
		_current_rows.append(row)

func get_trade_value() -> int:
	var trade_value : int = 0
	for row in _current_rows:
		trade_value += row.get_row_value()
	return trade_value