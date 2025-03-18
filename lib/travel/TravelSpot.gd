class_name TravelSpot
extends Resource

@export var name : StringName
@export var description : String

func _to_string() -> String:
	return "TravelSpot<%s>" % name