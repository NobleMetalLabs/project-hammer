class_name UIShipPanel
extends Control

@export var ship: Ship
@onready var ship_display : UIShipDisplay = $"%SHIP-DISPLAY"

func _ready():
	ship_display.input_event_on_ship_grid.connect(_handle_input_event_on_ship_grid)

var _input_handler_stack : Array[Node] = []
func _handle_input_event_on_ship_grid(event : InputEvent, coord : Vector3i):
	var current_input_handler : Node = _input_handler_stack.pop_back()
	if current_input_handler != null:
		current_input_handler.handle_input_event_on_ship_grid(event, coord)
		_input_handler_stack.push_back(current_input_handler)

func push_input_handler(new_input_handler : Node):
	print("Input handler %s requested focus." % new_input_handler)
	var current_input_handler : Node = _input_handler_stack.pop_back()
	if current_input_handler == null:
		_input_handler_stack.push_back(new_input_handler)
	else:
		_input_handler_stack.push_back(current_input_handler)
		if current_input_handler != new_input_handler:
			_input_handler_stack.push_back(new_input_handler)
		else:
			print("Handler already has focus.")

func pop_input_handler():
	print("Input handler popped.")
	_input_handler_stack.pop_back()