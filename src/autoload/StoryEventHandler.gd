#class_name StoryEventHandler
extends Node

var _story_event_occurrences : Dictionary = {} #[Callable, StoryEvent]

func register_storyevent_occurence(evaluator : Callable, event : StoryEvent) -> void:
	_story_event_occurrences[evaluator] = event

func deregister_storyevent_occurence(evaluator : Callable) -> void:
	_story_event_occurrences.erase(evaluator)

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
	ProjectHammerEventBus.subscribe("*", proc_storyevents)
	
	var trashland_event : StoryEvent = load("res://tst/story/TrashlandDirtyEvent.tres")
	register_storyevent_occurence(evaluate_trashland, trashland_event)
	var wash_event : StoryEvent = load("res://tst/story/WashedEvent.tres")
	var wash_fail_event : StoryEvent = load("res://tst/story/WashFailEvent.tres")
	register_storyevent_occurence(evaluate_wash, wash_fail_event)
	
	CommandServer.register_command(
		CommandBuilder.new()
		.Literal("trashland-command-test")
		.Callback(func(): register_storyevent_occurence(evaluate_wash, wash_event)
		)
		.Build()
	)
	CommandServer.register_command(
		CommandBuilder.new()
		.Literal("washed-up-test")
		.Callback(func(): register_storyevent_occurence(evaluate_wash, wash_fail_event)
		)
		.Build()
	)

func evaluate_trashland(event_name : StringName, data : Dictionary):
	if event_name != "travel/traveled_to_spot": return false
	return data["spot"].name == "Trashland"

func evaluate_wash(event_name : StringName, data : Dictionary):
	if event_name != "travel/traveled_to_spot": return false
	return data["spot"].name == "Wash"
