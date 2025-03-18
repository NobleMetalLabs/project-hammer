class_name NarrativeChunk
extends Resource

@export var description : String = ""
@export var result_description : String = ""
@export var result_commands : Array[String] = []
@export var next_event : NarrativeChunk = null


func _to_string() -> String:
	return "NarrativeChunk<%s>" % resource_path.get_file().get_basename()
