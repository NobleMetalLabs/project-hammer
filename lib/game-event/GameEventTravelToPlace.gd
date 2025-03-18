class_name GameEventTravelToPlace
extends GameEvent

@export var location : SectorLocation 
@export var spot : LocationSpot

func _init(_location : SectorLocation = null, _spot : LocationSpot = null):
	location = _location
	spot = _spot

func _equals(other : GameEventTravelToPlace) -> bool:
	return location == other.location and spot == other.spot

func _to_string() -> String:
	return "GE-TravelToPlace<%s, %s>" % [location, spot]
