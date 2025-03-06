extends Panel

var editing_dialogue : DialoguePart

func _ready() -> void:
	register_commands()
	
	CommandServer.run_command("file load res://tst/bonar.ser")

func register_commands() -> void:
	CommandServer.register_command(
		CommandBuilder.new()
			.Literal("file")
			.Literal("new")
			.Callback(func() -> void: 
				editing_dialogue = DialoguePart.new()
				ProjectHammerEventBus.push_event("dialogue_editor_initialize", {"root": editing_dialogue})
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
					ProjectHammerEventBus.push_event("dialogue_editor_initialize", {"root": editing_dialogue})
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
