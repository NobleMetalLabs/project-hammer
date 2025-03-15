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
	pass	

	#var wash_event : StoryEvent = load("res://tst/story/WashEvent.tres")
	#register_storyevent_occurance(func(), wash_event)



	