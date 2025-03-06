class_name UIDialoguePanel
extends Panel

@onready var header_label : Label = self.find_child("HEADER-LABEL", true, false)

@onready var text_edit : TextEdit = self.find_child("TEXT-EDIT", true, false)
@onready var command_edit : LineEdit = self.find_child("COMMAND-EDIT", true, false)

@onready var choices_container : VBoxContainer = self.find_child("CHOICES-CONTAINER", true, false)
@onready var add_choice_button : Button = self.find_child("ADD-CHOICE-BUTTON", true, false)
@onready var remove_choice_button : Button = self.find_child("REMOVE-CHOICE-BUTTON", true, false)

func _ready() -> void:
	pass

func set_header_text(text : String) -> void:
	header_label.text = text
func set_text_edit_text(text : String) -> void:
	text_edit.text = text
func set_command_edit_text(text : String) -> void:
	command_edit.text = text
