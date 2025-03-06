extends VBoxContainer

var dialogue_to_panel : Dictionary = {} #[DialoguePart, UIDialoguePanel]
@onready var panel_template : UIDialoguePanel = $"DIALOGUE-PANEL"

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
		
		# big scan for all the parts
		# also ig kill all children of this
	
	for dialogue_part in all_parts:
		if not dialogue_to_panel.has(dialogue_part):
			var new_panel : UIDialoguePanel = panel_template.duplicate()
			panel_template.add_sibling(new_panel)
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
