class_name UIDevDialoguePanel
extends Panel

@onready var header_label : Label = self.find_child("HEADER-LABEL", true, false)

@onready var text_edit : TextEdit = self.find_child("TEXT-EDIT", true, false)
@onready var command_edit : LineEdit = self.find_child("COMMAND-EDIT", true, false)

@onready var choices_container : VBoxContainer = self.find_child("CHOICES-CONTAINER", true, false)
@onready var choice_template : Label = self.find_child("CHOICE-TEMPLATE", true, false)
@onready var choice_edit : LineEdit = self.find_child("CHOICE-EDIT", true, false)
@onready var add_choice_button : Button = self.find_child("ADD-CHOICE-BUTTON", true, false)
@onready var remove_choice_button : Button = self.find_child("REMOVE-CHOICE-BUTTON", true, false)

func _ready() -> void:
	choice_template.visible = false

func set_header_text(text : String) -> void:
	header_label.text = text
func set_text_edit_text(text : String) -> void:
	text_edit.text = text
func set_command_edit_text(text : String) -> void:
	command_edit.text = text

func set_choices_container(choices : Dictionary) -> void:
	for choice_label : Label in choices_container.get_children(): 
		if choice_label != choice_template: choice_label.queue_free()
	
	var choice_index = 1
	for selection_text : String in choices.keys():
		var new_label : Label = choice_template.duplicate()
		choices_container.add_child(new_label)
		new_label.visible = true
		
		new_label.text = "%d. %s" % [choice_index, selection_text]
		choice_index += 1
