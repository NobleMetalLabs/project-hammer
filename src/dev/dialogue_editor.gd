extends Panel

var editing_dialogue : DialoguePart

func _ready() -> void:
	register_commands()
	ProjectHammerEventBus.subscribe("dialogue_editor_update", update_ui)

func register_commands() -> void:
	CommandServer.register_command(
		CommandBuilder.new()
			.Literal("file")
			.Literal("new")
			.Callback(func() -> void: 
				editing_dialogue = DialoguePart.new()
				ProjectHammerEventBus.push_event("dialogue_editor_update", {"dialogue": editing_dialogue})
				)
		.Build()
	)

	CommandServer.register_command(
		CommandBuilder.new()
			.Literal("file")
			.Literal("load")
			.Branch()
				.Validated("path", GlobalCommandValidators.is_valid_filepath).Tag_gnst()
				.Callback(func(path) -> void:
					editing_dialogue = FileManager.load_file(path, ["ser"])
					, ["path"])
		.Build()
	)
	
	CommandServer.register_command(
		CommandBuilder.new()
			.Literal("file")
			.Literal("save")
			.Branch()
				.Validated("path", GlobalCommandValidators.is_valid_filepath).Tag_gnst()
				.Callback(func(path) -> void:
					FileManager.save_file(editing_dialogue, path)
					, ["path"])
		.Build()
	)

func update_ui(data : Dictionary) -> void:
	pass
