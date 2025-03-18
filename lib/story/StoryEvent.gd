class_name StoryEvent
extends Resource

@export var description : String = ""
@export var result_description : String = ""
@export var result_commands : Array[String] = []
@export var next_event : StoryEvent = null


func _to_string() -> String:
	return "StoryEvent<%s>" % resource_path.get_file().get_basename()