class_name SectorLocation
extends Resource

@export var name : StringName
@export var description : String
@export var spots : Array[LocationSpot]

func _to_string() -> String:
	return "SectorLocation<%s>" % name