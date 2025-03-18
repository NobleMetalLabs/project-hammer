class_name UITravelSpotListDisplay
extends PanelContainer

@onready var item_row : Control = $"%ITEM-ROW"

var _current_spot_rows : Array[Control] = []

func _ready():
	item_row.hide()

func display_spots(spots : Array[LocationSpot]):
	for row in _current_spot_rows:
		row.queue_free()
	_current_spot_rows.clear()
	for spot in spots:
		_add_spot_row(spot)

signal spot_selected(spot : LocationSpot)

func _add_spot_row(spot : LocationSpot):
	var row = item_row.duplicate()
	var row_button : Button = row.get_node("BUTTON")
	row_button.pressed.connect(spot_selected.emit.bind(spot))
	row.show()
	row_button.text = spot.name
	#row.get_node("description").text = spot.description
	_current_spot_rows.append(row)
	item_row.get_parent().add_child(row)
	#row.connect("pressed", self, "_on_spot_pressed", [spot])
	if spot is LocationSpotGroup:
		row_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		for group_spot in spot.group_spots:
			_add_spot_row(group_spot)