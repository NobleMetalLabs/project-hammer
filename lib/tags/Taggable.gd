class_name Taggable
extends Resource

var tags : Array[Tag]

func get_tags_of_type(type : StringName) -> Array[Tag]:
	var return_tags : Array[Tag] = []
	for tag in tags:
		if tag.get_script().get_global_name() == type: return_tags.append(tag)
	return return_tags

func is_superset_of(other : Taggable, type_filter : StringName = "") -> bool:
	var curr_array : Array[Tag] = tags
	var other_array : Array[Tag] = other.tags
	if type_filter != "":
		curr_array = get_tags_of_type(type_filter)
		other_array = other.get_tags_of_type(type_filter)
	return tag_array_is_superset(curr_array, other_array)

func union(other : Taggable) -> void:
	tags = tag_array_union(tags, other.tags)

static func tag_array_is_superset(tags_a : Array[Tag], tags_b : Array[Tag]) -> bool:
	for tag in tags_b:
		if not tags_a.any(tag.equals): 
			return false
	return true

static func tag_array_subtract(tags_a : Array[Tag], tags_b : Array[Tag]) -> Array[Tag]:
	var return_tags := tags_a.duplicate()
	for tag in tags_b:
		if tags_a.any(tag.equals):
			return_tags.erase(tag)
	return return_tags

static func tag_array_union(tags_a : Array[Tag], tags_b : Array[Tag]) -> Array[Tag]:
	var return_tags := tags_a.duplicate()
	for tag in tags_b:
		if not tags_a.any(tag.equals):
			return_tags.append(tag)
	return return_tags

#static func filter_by_has_tag(items : Array[Taggable], type : StringName) -> Array[Taggable]:
	#return items.filter(func(item : Taggable) -> bool:
		#return not item.get_tags_of_type(type).is_empty()
		#)
#
#func is_any_enumtag_of_type_value(type : StringName, value : int) -> bool:
	#return get_tags_of_type(type).any(func(tag : EnumTag) -> bool: return tag.value == value)
	#
