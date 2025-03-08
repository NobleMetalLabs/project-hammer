class_name UITradingCargoListItemRow
extends PanelContainer

@onready var item_name_label : Label = self.find_child("ITEM-NAME-LABEL", true, false)
@onready var item_count_spinbox : SpinBox = self.find_child("ITEM-COUNT-SPINBOX", true, false)
@onready var item_max_label : Label = self.find_child("ITEM-MAX-LABEL", true, false)
@onready var item_none_button : Button = self.find_child("ITEM-NONE-BUTTON", true, false)
@onready var item_half_button : Button = self.find_child("ITEM-HALF-BUTTON", true, false)
@onready var item_all_button : Button = self.find_child("ITEM-ALL-BUTTON", true, false)
@onready var item_price_label : Label = self.find_child("ITEM-PRICE-LABEL", true, false)

var cargo_item : CargoItem

func _ready():
	# item_count_spinbox.get_line_edit().text_submitted.connect(
	# 	func(_t) -> void:
	# 		print("PLEASE RELASE FOCUS")
	# 		item_count_spinbox.release_focus() #I LOVE GODOT
	# )
	item_count_spinbox.value_changed.connect(
		func(value : int) -> void:
			item_count_changed.emit(CargoItem.new(cargo_item.item, value))
	)

	item_none_button.pressed.connect(
		func() -> void:
			item_count_spinbox.value = 0
	)
	item_all_button.pressed.connect(
		func() -> void:
			item_count_spinbox.value = int(cargo_item.quantity)
	)

signal item_count_changed(cargo_item : CargoItem)

var _item_trade_value : int = 1

func set_item_row_data(_cargo_item : CargoItem) -> void:
	cargo_item = _cargo_item
	item_name_label.text = ItemDB.item_string(cargo_item.item)
	item_count_spinbox.value = 0
	item_count_spinbox.max_value = cargo_item.quantity
	item_max_label.text = "/ %s" % [cargo_item.quantity]
	item_price_label.text = "%s₿" % [_item_trade_value]

func get_row_value() -> int:
	return int(item_count_spinbox.value) * _item_trade_value