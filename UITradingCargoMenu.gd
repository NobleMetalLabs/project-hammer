class_name UITradingCargoMenu
extends PanelContainer

signal close_menu()

var _player_cargo : Cargo
var _trader_cargo : Cargo

@onready var _player_list_display : UITradingCargoListDisplay = self.find_child("PLAYER-LIST-DISPLAY", true, false)
@onready var _player_currency_display : UITradingCurrencyListDisplay = self.find_child("PLAYER-CURRENCY-DISPLAY", true, false)
@onready var _trader_list_display : UITradingCargoListDisplay = self.find_child("TRADER-LIST-DISPLAY", true, false)
@onready var _trader_currency_display : UITradingCurrencyListDisplay = self.find_child("TRADER-CURRENCY-DISPLAY", true, false)


@onready var _trade_button : Button = self.find_child("TRADE-BUTTON", true, false)
@onready var _close_button : Button = self.find_child("CLOSE-BUTTON", true, false)

func _ready():
	_player_cargo = Cargo.new()
	_player_cargo.add_item(CargoItem.new(0 as ItemDB.Item, 10))
	_player_cargo.add_item(CargoItem.new(1 as ItemDB.Item, 20))
	_trader_cargo = Cargo.new()
	_trader_cargo.add_item(CargoItem.new(3 as ItemDB.Item, 10))
	_trader_cargo.add_item(CargoItem.new(4 as ItemDB.Item, 20)) 

	setup_menu(_player_cargo, _trader_cargo)

	_player_list_display.trade_changed.connect(update_trade_values)
	_trader_list_display.trade_changed.connect(update_trade_values)
	_player_currency_display.currency_count_changed.connect(update_trade_values)
	_trader_currency_display.currency_count_changed.connect(update_trade_values)

	_trade_button.pressed.connect(try_complete_trade)
	_close_button.pressed.connect(close_menu.emit)

func setup_menu(player_cargo : Cargo, trader_cargo : Cargo) -> void:
	_player_cargo = player_cargo
	_trader_cargo = trader_cargo

	_player_list_display.set_cargo(_player_cargo)
	_trader_list_display.set_cargo(_trader_cargo)

	_player_currency_display.set_currency(100, 100)
	_trader_currency_display.set_currency(100, 100)

	update_trade_values()

func update_trade_values() -> void:
	var p_val : int = _get_player_trade_value()
	var t_val : int = _get_trader_trade_value()
	_player_currency_display.set_trade_values(p_val, t_val)
	_trader_currency_display.set_trade_values(t_val, p_val)

func _get_player_trade_value() -> int:
	return _player_list_display.get_trade_value() + _player_currency_display.current_trade_money_modification + _player_currency_display.current_trade_goodwill_modification

func _get_trader_trade_value() -> int:
	return _trader_list_display.get_trade_value() + _trader_currency_display.current_trade_money_modification + _trader_currency_display.current_trade_goodwill_modification

func try_complete_trade() -> void:
	var player_goods_value : int = _get_player_trade_value()
	var trader_goods_value : int = _get_trader_trade_value()

	if player_goods_value == trader_goods_value:
		complete_trade()
	else:
		print("Trade values do not match")

func complete_trade() -> void:
	for cargo_item in _player_list_display._current_cargo_modifications.values():
		_player_cargo.remove_item(cargo_item)
		_trader_cargo.add_item(cargo_item)
	for cargo_item in _trader_list_display._current_cargo_modifications.values():
		_trader_cargo.remove_item(cargo_item)
		_player_cargo.add_item(cargo_item)

	#TODO: implement faction, player, vender currency storage and use them
	
	#player_currency -= _player_currency_display.current_trade_money_modification
	#player_currency += _trader_currency_display.current_trade_money_modification
	#trader_currency -= _trader_currency_display.current_trade_money_modification
	#trader_currency += _trader_currency_display.current_trade_money_modification
	#player_goodwill -= _player_currency_display.current_trade_goodwill_modification
	#player_goodwill += _trader_currency_display.current_trade_goodwill_modification
	#trader_goodwill -= _trader_currency_display.current_trade_goodwill_modification
	#trader_goodwill += _trader_currency_display.current_trade_goodwill_modification

	print(_player_cargo)
	print(_trader_cargo)

	setup_menu(_player_cargo, _trader_cargo)