class_name UIDialoguePanel
extends Control

@onready var text_label : Label = $"%TEXT-LABEL"
@onready var button_one : Button = $"%BUTTON-ONE"
@onready var button_two : Button = $"%BUTTON-TWO"
@onready var button_three : Button = $"%BUTTON-THREE"
@onready var button_four : Button = $"%BUTTON-FOUR"
@onready var buttons : Array[Button] = [button_one, button_two, button_three, button_four]

@onready var fullscreen_parent_container : VBoxContainer = get_parent().get_parent()

var _current_story_event : NarrativeChunk = null
func _ready():
	for button_idx in range(4):
		var button = buttons[button_idx]
		button.pressed.connect(button_pressed.bind(button_idx))

	NarrativeChunkHandler.display_narrative_chunk.connect(set_current_story_event)

func set_current_story_event(story_event : NarrativeChunk) -> void:
	_current_story_event = story_event
	ProjectHammerLogger.log(["UI", "NARRATION"], "Displaying %s" % story_event)
	update_ui()

func update_ui() -> void:
	self.hide()
	fullscreen_parent_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if _current_story_event == null: return
	self.show()
	fullscreen_parent_container.mouse_filter = Control.MOUSE_FILTER_STOP
	text_label.text = _current_story_event.description
	for button in buttons:
		button.visible = false
		button.disabled = true
	if not _current_story_event is NarrativeChoiceChunk:
		button_one.text = "1. Continue"
		button_one.visible = true
		button_one.disabled = false
		return
	else:
		var curr_choices : Array[NarrativeChoice] = _current_story_event.choices
		for choice_idx in range(len(curr_choices)):
			var choice : NarrativeChoice = curr_choices[choice_idx]
			var button = buttons[choice_idx]
			button.text = "%d. %s" % [choice_idx + 1, choice.text]
			button.visible = true
			button.disabled = false

func button_pressed(button_index : int) -> void:
	await get_tree().create_timer(0.2).timeout
	var next_event : NarrativeChunk = null
	if not _current_story_event is NarrativeChoiceChunk:
		next_event = _current_story_event.next_event
	else:
		next_event = _current_story_event.choices[button_index].resulting_narrative
	NarrativeChunkHandler.handle_story_event_advance(next_event)
