class_name UITradingCurrencyListDisplay
extends PanelContainer

@onready var current_trade_value_label : Label = self.find_child("CURRENT-TRADE-VALUE-LABEL", true, false)
@onready var money_count_spinbox : SpinBox = self.find_child("MONEY-COUNT-SPINBOX", true, false)
@onready var money_max_label : Label = self.find_child("MONEY-MAX-LABEL", true, false)
@onready var money_none_button : Button = self.find_child("MONEY-NONE-BUTTON", true, false)
@onready var money_enough_button : Button = self.find_child("MONEY-ENOUGH-BUTTON", true, false)
@onready var goodwill_count_spinbox : SpinBox = self.find_child("GOODWILL-COUNT-SPINBOX", true, false)
@onready var goodwill_max_label : Label = self.find_child("GOODWILL-MAX-LABEL", true, false)
@onready var goodwill_none_button : Button = self.find_child("GOODWILL-NONE-BUTTON", true, false)
@onready var goodwill_enough_button : Button = self.find_child("GOODWILL-ENOUGH-BUTTON", true, false)

var _current_trade_value : int = 0
var _current_trade_opposing_trade_value : int = 0

var current_trade_money_modification : int = 0
var current_trade_goodwill_modification : int = 0

signal currency_count_changed()

func _ready():
	money_none_button.pressed.connect(func() -> void:
		current_trade_money_modification = 0
		money_count_spinbox.value = 0
		currency_count_changed.emit()
	)
	goodwill_none_button.pressed.connect(func() -> void:
		current_trade_goodwill_modification = 0
		goodwill_count_spinbox.value = 0
		currency_count_changed.emit()
	)
	money_enough_button.pressed.connect(func() -> void:
		current_trade_money_modification = _current_trade_opposing_trade_value - _current_trade_value
		money_count_spinbox.value = current_trade_money_modification
		currency_count_changed.emit()
	)
	goodwill_enough_button.pressed.connect(func() -> void:
		current_trade_goodwill_modification = _current_trade_opposing_trade_value - _current_trade_value
		goodwill_count_spinbox.value = current_trade_goodwill_modification
		currency_count_changed.emit()
	)

	money_count_spinbox.value_changed.connect(
		func(value : int) -> void:
			current_trade_money_modification = value
			currency_count_changed.emit()

	)
	goodwill_count_spinbox.value_changed.connect(
		func(value : int) -> void:
			current_trade_goodwill_modification = value
			currency_count_changed.emit()
	)

func set_currency(possessed_money : int, possessed_goodwill : int) -> void:
	current_trade_money_modification = 0
	money_count_spinbox.value = 0
	money_count_spinbox.max_value = possessed_money
	money_max_label.text = "/ %s" % [possessed_money]
	current_trade_goodwill_modification = 0
	goodwill_count_spinbox.value = 0
	goodwill_count_spinbox.max_value = possessed_goodwill
	goodwill_max_label.text = "/ %s" % [possessed_goodwill]

func set_trade_values(trade_value : int, opposing_trade_value : int) -> void:
	_current_trade_value = trade_value
	_current_trade_opposing_trade_value = opposing_trade_value
	current_trade_value_label.text = "%s₿" % [_current_trade_value]

	if _current_trade_value >= opposing_trade_value:
		money_enough_button.disabled = true
		goodwill_enough_button.disabled = true
	else:
		money_enough_button.disabled = false
		goodwill_enough_button.disabled = false
