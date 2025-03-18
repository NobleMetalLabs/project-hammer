#class_name QuestlineManager
extends Node

var active_quests : Array[Questline] = []

var _current_processing_questline : Questline = null
var story_related_event_buffer : Array[StoryRelatedEvent] = []
func handle_story_related_event(event : StoryRelatedEvent) -> void:
	if _current_processing_questline != null: 
		story_related_event_buffer.append(event)
		return
	for quest in active_quests:
		_current_processing_questline = quest
		quest.handle_storyrelatedevent(event)
	_current_processing_questline = null

func _flush_streev_buffer() -> void:
	for event in story_related_event_buffer:
		handle_story_related_event(event)
	story_related_event_buffer.clear()

func handle_story_event_advance(next_event : StoryEvent) -> void:
	if next_event == null: 
		ProjectHammerLogger.log(["STORY", "QUEST", "STORYEVENT"], "Questline finished processing")
		_current_processing_questline = null
		_flush_streev_buffer()
		return
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
