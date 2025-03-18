class_name TravelLocation
extends Resource

@export var name : StringName
@export var description : String
@export var spots : Array[TravelSpot]

func _to_string() -> String:
	return "TravelLocation<%s>" % name