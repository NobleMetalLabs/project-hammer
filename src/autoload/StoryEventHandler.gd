#class_name StoryEventHandler
extends Node

var _story_event_occurrences : Dictionary = {} #[StoryRelatedEvent, StoryEvent]

func register_storyevent_occurence(related_event : StoryRelatedEvent, event : StoryEvent) -> void:
	_story_event_occurrences[related_event] = event

func deregister_storyevent_occurence(related_event : StoryRelatedEvent) -> void:
	_story_event_occurrences.erase(related_event)

func process_storyrelatedevent(related_event : StoryRelatedEvent) -> void:

	ProjectHammerLogger.log(["STORY", "EVENT"], "Processing %s" % related_event)
	ProjectHammerLogger.log(["STORY", "EVENT", "EMERGENT"], "Does event trigger any emergent StoryEvents?")
	if _story_event_occurrences.has(related_event):
		var emergent_event : StoryEvent = _story_event_occurrences[related_event]
		ProjectHammerLogger.log(["STORY", "EVENT", "EMERGENT"], "Triggering event %s" % emergent_event)
		_display_storyevent(emergent_event)

	ProjectHammerLogger.log(["STORY", "EVENT", "QUEST"], "Does event trigger any questline advancements?")
	QuestlineManager.handle_story_related_event(related_event)

signal display_storyevent(event : StoryEvent) #TODO: better word than "display"

func _display_storyevent(event : StoryEvent) -> void:
	ProjectHammerLogger.log(["STORY", "STORYEVENT"], "Triggering %s" % event)
	display_storyevent.emit(event)
	if event == null: return # TODO: dont tell ui to display null just check for null and tell it to hide
	
	QuestlineManager.handle_story_event_advance.call(event)
	for command in event.result_commands:
		CommandServer.run_command(command)

func handle_story_event_advance(next_event : StoryEvent) -> void:
	_display_storyevent(next_event)