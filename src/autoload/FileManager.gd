#class_name FileManager
extends Node

var _last_action_result : int = Error.OK

func get_error() -> int:
	return _last_action_result

func save_file(contents : Serializeable, filepath : String) -> void:
	if not contents:
		#ParasiteLogger.error("Failed to save file. Contents is null.")
		return
	var data_dict : Dictionary = contents.serialize()
	var dirs : PackedStringArray = filepath.split("/")
	for dir : String in dirs.slice(1, -1):
		var dirpath : String = "/".join(dirs.slice(0, dirs.find(dir) + 1))
		if not DirAccess.dir_exists_absolute(dirpath):
			DirAccess.make_dir_absolute(dirpath)
	var fa : FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	var fa_err : int = FileAccess.get_open_error()
	_last_action_result = fa_err
	if fa_err != OK:
		#ParasiteLogger.error("Failed to save file. \"%s\" error." % [error_string(fa_err)])
		return
	fa.store_string(JSON.stringify(data_dict))
	#ParasiteLogger.log(["FILE"], "Saved file \"%s\"." % [filepath])
	return

func load_file(filepath : String, extensions : Array[String]) -> Serializeable:
	var path_ext : String = filepath.get_extension()
	if path_ext not in extensions:
		print(
			"Failed to load file. File extension \"%s\" not one of the permitted (%s)." % 
			[path_ext, ", ".join(extensions.map(func(s : String) -> String: return ".%s" % s))]
		)
		return
	var fa : FileAccess = FileAccess.open(filepath, FileAccess.READ)
	var fa_err : int = FileAccess.get_open_error()
	_last_action_result = fa_err
	if fa_err != OK:
		print("Failed to load file. \"%s\" error." % [error_string(fa_err)])
		return
	var data_json : String = fa.get_line()
	var data_dict : Dictionary = JSON.parse_string(data_json)
	#TODO: check for malformed data_dict / deserialization
	var object : Serializeable = Serializeable.deserialize(data_dict)
	#ParasiteLogger.log(["FILE"], "Loaded file.")
	return object

func get_dir_contents(dirpath : String, deep : bool = false) -> Array[String]:
	var da : DirAccess = DirAccess.open(dirpath)
	var da_err : int = DirAccess.get_open_error()
	_last_action_result = da_err
	if da_err != OK:
		#ParasiteLogger.error("Failed to get directory contents. \"%s\" error." % [error_string(da_err)])
		return []
	var files : PackedStringArray = da.get_files()
	var directories : PackedStringArray = da.get_directories()
	if deep:
		for dir : String in directories:
			var sub_files : Array[String] = []
			sub_files.assign(get_dir_contents(dirpath + dir, true))
			files.append_array(sub_files.map(func (s : String) -> String: return "%s/%s" % [dir, s]))
	var output : Array[String] = []
	output.assign(files)
	return output
