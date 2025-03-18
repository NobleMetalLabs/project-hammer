class_name StoryRelatedEventObtainThing 
extends StoryRelatedEvent

@export var thing : StringName = ""

func _init(_thing : StringName = ""):
	thing = _thing

func _equals(other : StoryRelatedEventObtainThing) -> bool:
	return thing.to_lower() == other.thing.to_lower()

func _to_string() -> String:
	return "StReEv-ObtainThing<%s>" % [thing]
