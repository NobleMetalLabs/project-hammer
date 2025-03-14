#class_name StoryEventHandler
extends Node

var _story_event_occurrences : Dictionary = {} #[Callable, StoryEvent]

func register_storyevent_occurance(evaluator : Callable, event : StoryEvent) -> void:
	_story_event_occurrences[evaluator] = event

func proc_storyevents(event_name : StringName, data : Dictionary = {}) -> void:
	for evaluator : Callable in _story_event_occurrences.keys():
		var does_event_occur : bool = evaluator.call(event_name, data)
		if does_event_occur:
			_display_storyevent(_story_event_occurrences[evaluator])

signal display_storyevent(event : StoryEvent)

func _display_storyevent(event : StoryEvent) -> void:
	display_storyevent.emit(event)
	if event == null: return # TODO: dont tell ui to display null just check for null and tell it to hide

	for command in event.result_commands:
		CommandServer.run_command(command)

func handle_story_event_advance(next_event : StoryEvent) -> void:
	_display_storyevent(next_event)

func _ready():
	var e := StoryEvent.new()
	e.description = "This is a test event"
	var e2 := StoryChoiceEvent.new()
	e.next_event = e2
	e2.description = "This is a test event 2"
	var e3 := StoryEvent.new()
	e3.description = "Option 1"
	var e4 := StoryEvent.new()
	e4.description = "Option 2"
	var ec1 := StoryChoiceEventChoice.new()
	ec1.text = "Choice 1"
	ec1.resulting_event = e3
	var ec2 := StoryChoiceEventChoice.new()
	ec2.text = "Choice 2"
	ec2.resulting_event = e4
	e2.choices = [ec1, ec2]
	
	print("disp")
	_display_storyevent.call_deferred(e)

	