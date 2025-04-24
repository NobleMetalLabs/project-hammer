class_name LocationSpot
extends Actor

@export var name : StringName
@export var description : String

func _to_string() -> String:
	return "LocationSpot<%s>" % name
