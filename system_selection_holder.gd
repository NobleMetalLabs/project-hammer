extends VBoxContainer

signal selected_system(system_script)
func _ready() -> void:
	var scripts = FileHelper.search_directory_for_objects("res://lib/ship/systems/")
	for script : Script in scripts:
		var classname = script.get_global_name()
		
		# temp will use image later
		var button = Button.new()
		button.text = classname
		
		button.pressed.connect(func():
			selected_system.emit(script)
		)
		
		add_child(button, true)
