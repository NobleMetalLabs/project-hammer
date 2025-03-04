extends Panel

@onready var current_cargo_label : RichTextLabel = $"%CURRENT-CARGO-LABEL"
@onready var add_toggle_button : Button = $"%ADD-TOGGLE-BUTTON"
@onready var remove_toggle_button : Button = $"%REMOVE-TOGGLE-BUTTON"
@onready var quantity_spinbox : SpinBox = $"%QUANTITY-SPINBOX"

@onready var cargo_item_button_stack : FlowContainer = $"%CARGO-ITEM-BUTTON-STACK"

var cargo := Cargo.new()

func _ready() -> void:
	var bg := ButtonGroup.new()
	add_toggle_button.button_group = bg
	remove_toggle_button.button_group = bg
	add_toggle_button.button_pressed = true

	for item : ItemDB.Item in ItemDB.Item.values():
		var button : Button = Button.new()
		button.text = ItemDB.item_string(item)
		button.pressed.connect(
			handle_button_press.bind(item)
		)
		cargo_item_button_stack.add_child(button)

func handle_button_press(item : ItemDB.Item) -> void:
	if add_toggle_button.button_pressed:
		cargo.add_item(CargoItem.new(item, int(quantity_spinbox.value)))
	else:
		cargo.remove_item(CargoItem.new(item, int(quantity_spinbox.value)))
	refresh_cargo_label()


func refresh_cargo_label() -> void:
	var text : String = ""
	for cargo_item : CargoItem in cargo.items:
		text += ItemDB.item_string(cargo_item.item) + ": " + str(cargo_item.quantity) + "\n"
	current_cargo_label.text = text