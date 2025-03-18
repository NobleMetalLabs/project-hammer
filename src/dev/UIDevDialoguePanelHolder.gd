extends VBoxContainer

var part_to_panel : Dictionary = {} #[DialoguePart, UIDialoguePanel]
@onready var panel_template : UIDevDialoguePanel = $"DIALOGUE-PANEL"

var root : DialoguePart

func _ready() -> void:
	panel_template.visible = false
	
	ProjectHammerFallbackEventBus.subscribe("dialogue_editor_initialize", update)

func update(data : Dictionary) -> void:
	for dialogue_panel : UIDevDialoguePanel in get_children(): 
		if dialogue_panel != panel_template: dialogue_panel.queue_free()
	
	root = data["root"]
	add_panel_from_part(root)
	get_all_parts_from(root, true)

func get_all_parts_from(dialogue_part : DialoguePart, add : bool = false) -> Array:
	var direct_parts = dialogue_part.choices.values()
	if direct_parts.is_empty(): return []
	
	var parts = direct_parts.duplicate()
	for new_part in direct_parts: 
		if add: add_panel_from_part(new_part, dialogue_part).set_header_text \
		("%s from %s" % [dialogue_part.choices.find_key(new_part), part_to_panel[dialogue_part].header_label.text])
		parts.append_array(get_all_parts_from(new_part, add))
	return parts

func add_panel_from_part(dialogue_part : DialoguePart, origin : DialoguePart = null) -> UIDevDialoguePanel:
	var new_panel : UIDevDialoguePanel = panel_template.duplicate()
	add_child(new_panel)
	new_panel.visible = true
	
	if origin == null: new_panel.set_header_text("Root")
	
	new_panel.set_text_edit_text(dialogue_part.text)
	new_panel.set_command_edit_text(dialogue_part.command)
	new_panel.text_edit.text_changed.connect(func():
		dialogue_part.text = new_panel.text_edit.text
	)
	new_panel.command_edit.text_changed.connect(func(text):
		dialogue_part.command = text
	)
	
	new_panel.set_choices_container(dialogue_part.choices)
	new_panel.add_choice_button.pressed.connect(func():
		var new_part := DialoguePart.new()
		if dialogue_part.choices.has(new_panel.choice_edit.text): return
		
		dialogue_part.choices[new_panel.choice_edit.text] = new_part
		new_panel.set_choices_container(dialogue_part.choices)
		
		add_panel_from_part(new_part, dialogue_part).set_header_text("%s from %s" % [new_panel.choice_edit.text, new_panel.header_label.text])
	)
	
	new_panel.remove_choice_button.pressed.connect(func():
		if dialogue_part.choices.has(new_panel.choice_edit.text):
			var removed_choice := new_panel.choice_edit.text
			var removed_part : DialoguePart = dialogue_part.choices[removed_choice]
			
			remove_panel_from_part(removed_part)
			for part in get_all_parts_from(removed_part):
				remove_panel_from_part(part)
			
			dialogue_part.choices.erase(removed_choice)
			
			new_panel.set_choices_container(dialogue_part.choices)
	)
	
	part_to_panel[dialogue_part] = new_panel
	return new_panel

func remove_panel_from_part(dialogue_part : DialoguePart) -> void:
	part_to_panel[dialogue_part].queue_free()
	part_to_panel.erase(dialogue_part)
