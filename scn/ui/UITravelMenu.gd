class_name UITravelMenu
extends PanelContainer

@onready var location_label : Label = $"%LOC-LABEL"
@onready var spot_list_display : UITravelSpotListDisplay = $"%SPOT-LIST-DISPLAY"
@onready var leave_button : Button = $"%LEAVE-BUTTON"

func _ready():
	var l : TravelLocation = load("res://tst/BruhcagoLoc.tres")
	print(l)
	display_travel_menu(l)
	
	spot_list_display.spot_selected.connect(_handle_travel)
	leave_button.pressed.connect(_handle_leave)

var _current_location : TravelLocation = null

func display_travel_menu(location : TravelLocation) -> void:
	_current_location = location
	location_label.text = location.name
	spot_list_display.display_spots(location.spots)
	
func _handle_travel(spot : TravelSpot) -> void:
	print("Traveling to %s." % spot.name)
	ProjectHammerEventBus.push_event(
		"travel/traveled_to_spot",
		{
			"spot" : spot
		}
	)

func _handle_leave() -> void:
	print("Leaving location %s." % _current_location.name)
	self.hide()
	ProjectHammerEventBus.push_event(
		"travel/left_location",
		{
			"location" : _current_location
		}
	)
