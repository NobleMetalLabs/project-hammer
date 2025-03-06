class_name UIDialoguePanel
extends Control

@onready var text_label : Label = $"%TEXT-LABEL"
@onready var button_one : Button = $"%BUTTON-ONE"
@onready var button_two : Button = $"%BUTTON-TWO"
@onready var button_three : Button = $"%BUTTON-THREE"
@onready var button_four : Button = $"%BUTTON-FOUR"
@onready var buttons : Array[Button] = [button_one, button_two, button_three, button_four]

var _current_dialogue_part : DialoguePart = null
signal dialogue_ended()

func _ready():
	for button_idx in range(4):
		var button = buttons[button_idx]
		button.pressed.connect(button_pressed.bind(button_idx))

	set_current_dialogue_part(
		Serializeable.deserialize(
			JSON.parse_string(
				FileAccess.open("res://tst/bonar.ser", FileAccess.READ).get_as_text()
			)
		)
	)

func set_current_dialogue_part(dialogue_part : DialoguePart) -> void:
	_current_dialogue_part = dialogue_part
	if _current_dialogue_part == null: return
	update_ui()

func update_ui() -> void:
	text_label.text = _current_dialogue_part.text
	for button in buttons:
		button.visible = false
		button.disabled = true
	if _current_dialogue_part.choices.is_empty():
		button_one.text = "1. Continue"
		button_one.visible = true
		button_one.disabled = false
		return
	else:
		for choice_idx in range(len(_current_dialogue_part.choices.keys())):
			var button = buttons[choice_idx]
			button.text = _current_dialogue_part.choices.keys()[choice_idx]
			button.visible = true
			button.disabled = false

func button_pressed(button_index : int) -> void:
	await get_tree().create_timer(0.2).timeout 
	if _current_dialogue_part.choices.is_empty():
		dialogue_ended.emit()
	else:
		set_current_dialogue_part(_current_dialogue_part.choices.values()[button_index])