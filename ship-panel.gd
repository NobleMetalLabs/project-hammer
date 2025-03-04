extends Panel

@export var ship: Ship
@onready var ship_display : UIShipDisplay = $"%SHIP-DISPLAY"

func _ready():
	ship_display.input_event_on_ship_grid.connect(handle_input_event_on_ship_grid)

var current_input_handler : Node = null
func handle_input_event_on_ship_grid(event : InputEvent, coord : Vector3i):
	if current_input_handler != null:
		current_input_handler.handle_input_event_on_ship_grid(event, coord)
	