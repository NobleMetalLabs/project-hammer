class_name Taggable
extends Resource

var tags : Array[Tag]

func get_tags_of_type(type : StringName) -> Array[Tag]:
	var return_tags : Array[Tag] = []
	for tag in tags:
		if tag.get_script().get_global_name() == type: return_tags.append(tag)
	return return_tags
