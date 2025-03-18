class_name StoryRelatedEventTravelToPlace
extends StoryRelatedEvent

@export var location : TravelLocation 
@export var spot : TravelSpot

func _init(_location : TravelLocation = null, _spot : TravelSpot = null):
	location = _location
	spot = _spot

func _equals(other : StoryRelatedEventTravelToPlace) -> bool:
	return location == other.location and spot == other.spot

func _to_string() -> String:
	return "StReEv-TravelToPlace<%s, %s>" % [location, spot]
