extends VBoxContainer

var part_to_panel : Dictionary = {} #[DialoguePart, UIDialoguePanel]
@onready var panel_template : UIDevDialoguePanel = $"DIALOGUE-PANEL"

var all_parts : Array[DialoguePart]
var root : DialoguePart

func _ready() -> void:
	panel_template.visible = false
	
	ProjectHammerEventBus.subscribe("dialogue_parts_changed", update)

func update(data : Dictionary) -> void:
	# on initialization (new or load)
	if data.has("start_dialogue"):
		all_parts.clear()
		
		root = data["start_dialogue"]
		all_parts.append(root)
		
		# do a big scan for all the parts
		
		for dialogue_panel : UIDevDialoguePanel in get_children(): 
			if dialogue_panel != panel_template: dialogue_panel.queue_free()
	
	for dialogue_part in all_parts:
		if not part_to_panel.has(dialogue_part):
			var new_panel : UIDevDialoguePanel = panel_template.duplicate()
			add_child(new_panel)
			new_panel.visible = true
			
			if dialogue_part == root: new_panel.set_header_text("Root")
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
				dialogue_part.choices[new_panel.choice_edit.text] = new_part
				new_panel.set_choices_container(dialogue_part.choices)
				
				all_parts.append(new_part)
				ProjectHammerEventBus.push_event("dialogue_parts_changed", {})
			)
			
			new_panel.remove_choice_button.pressed.connect(func():
				if dialogue_part.choices.size() > 0:
					var removed_choice : String = dialogue_part.choices.keys().back()
					var removed_part : DialoguePart = dialogue_part.choices[removed_choice]
					
					dialogue_part.choices.erase(removed_choice)
					
					all_parts.erase(removed_part)
					part_to_panel[removed_part].queue_free()
					
				new_panel.set_choices_container(dialogue_part.choices)
			)
			
			part_to_panel[dialogue_part] = new_panel
