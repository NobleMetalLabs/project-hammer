class_name Actor
extends Resource

var tags : TagTree = TagTree.new()

func _to_string() -> String:
	return "Actor[" + get_script().get_global_name() + "]"
