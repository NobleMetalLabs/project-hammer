class_name GameEventObtainThing 
extends GameEvent

@export var thing : StringName = ""

func _init(_thing : StringName = ""):
	thing = _thing

func _equals(other : GameEventObtainThing) -> bool:
	return thing.to_lower() == other.thing.to_lower()

func _to_string() -> String:
	return "GE-ObtainThing<%s>" % [thing]
