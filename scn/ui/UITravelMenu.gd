class_name UITravelMenu
extends PanelContainer

@onready var location_label : Label = $"%LOC-LABEL"
@onready var spot_list_display : UITravelSpotListDisplay = $"%SPOT-LIST-DISPLAY"
@onready var leave_button : Button = $"%LEAVE-BUTTON"

func _ready():
	var l : SectorLocation = load("res://tst/story/BruhcagoLoc.tres")
	display_travel_menu(l)
	
	spot_list_display.spot_selected.connect(_handle_travel)
	leave_button.pressed.connect(_handle_leave)

var _current_location : SectorLocation = null
var _current_spot : LocationSpot = null

func display_travel_menu(location : SectorLocation) -> void:
	_current_location = location
	location_label.text = location.name
	spot_list_display.display_spots(location.spots)
	self.show()
	
func _handle_travel(spot : LocationSpot) -> void:
	print("Traveling to %s." % spot.name)
	_current_spot = spot
	NarrativeChunkHandler.process_game_event(GameEventTravelToPlace.new(_current_location, _current_spot))

func _handle_leave() -> void:
	print("Leaving location %s." % _current_location.name)
	self.hide()
	ProjectHammerFallbackEventBus.push_event(
		"travel/left_location",
		{
			"location" : _current_location
		}
	)
