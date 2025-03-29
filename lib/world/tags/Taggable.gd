class_name Taggable
extends Resource

var tags : Array[Tag]

func get_tags_of_type(type : StringName) -> Array[Tag]:
	var return_tags : Array[Tag] = []
	for tag in tags:
		if tag.get_script().get_global_name() == type: return_tags.append(tag)
	return return_tags

#static func filter_by_has_tag(items : Array[Taggable], type : StringName) -> Array[Taggable]:
	#return items.filter(func(item : Taggable) -> bool:
		#return not item.get_tags_of_type(type).is_empty()
		#)
#
#func is_any_enumtag_of_type_value(type : StringName, value : int) -> bool:
	#return get_tags_of_type(type).any(func(tag : EnumTag) -> bool: return tag.value == value)
	#
