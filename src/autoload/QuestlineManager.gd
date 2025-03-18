#class_name QuestlineManager
extends Node

var active_quests : Array[Questline] = []

var _current_processing_questline : Questline = null
func handle_story_related_event(event : StoryRelatedEvent) -> void:
	for quest in active_quests:
		_current_processing_questline = quest
		quest.handle_storyrelatedevent(event)
	_current_processing_questline = null

func handle_story_event_advance(next_event : StoryEvent) -> void:
	if _current_processing_questline == null: return
	_current_processing_questline.handle_story_event_advance(next_event)

func _ready():
	var q : Questline = load("res://tst/story/qlines/blacksmith-order-quest.tres")
	active_quests.append(q)
	_current_processing_questline = q
	StoryEventHandler._display_storyevent.call_deferred(q.beginning_event)
	
	CommandServer.register_command(
		CommandBuilder.new()
		.Literal("give-item")
		.Literal("ore")
		.Callback(func():
			StoryEventHandler.process_storyrelatedevent(StoryRelatedEventObtainThing.new("Ore"))
			)
		.Build()
	)
