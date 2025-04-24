class_name SectorLocation
extends Actor

@export var name : StringName
@export var description : String
@export var spots : Array[LocationSpot]
@export var sublocations : Array[SectorLocation]

func _to_string() -> String:
	return "SectorLocation<%s>" % name
