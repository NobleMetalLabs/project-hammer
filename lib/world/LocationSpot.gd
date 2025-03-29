class_name LocationSpot
extends Taggable

@export var name : StringName
@export var description : String

func _to_string() -> String:
	return "LocationSpot<%s>" % name
