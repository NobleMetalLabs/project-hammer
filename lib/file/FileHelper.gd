class_name FileHelper
extends RefCounted

static func search_directory_for_objects(path : String, include_subdirectories : bool = false) -> Array[Object]:
	var result : Array[Object] = []
	var dir := DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name : String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if include_subdirectories:
					result.append_array(search_directory_for_objects(path + file_name + "/", true))
			else:
				var obj : Object = load(path + file_name.trim_suffix(".remap").trim_suffix(".import"))
				result.append(obj)
			file_name = dir.get_next()
	return result