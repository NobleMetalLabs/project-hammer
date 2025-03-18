#class_name QuestlineManager
extends Node

var active_quests : Array[Questline] = []

var _current_processing_questline : Questline = null
var game_event_buffer : Array[GameEvent] = []
func handle_story_related_event(event : GameEvent) -> void:
	if _current_processing_questline != null: 
		game_event_buffer.append(event)
		return
	for quest in active_quests:
		_current_processing_questline = quest
		quest.handle_game_event(event)
	_current_processing_questline = null

func _flush_game_event_buffer() -> void:
	for event in game_event_buffer:
		handle_story_related_event(event)
	game_event_buffer.clear()

func handle_story_event_advance(next_event : NarrativeChunk) -> void:
	if next_event == null: 
		ProjectHammerLogger.log(["STORY", "QUEST", "NARRATION"], "Questline finished processing")
		_current_processing_questline = null
		_flush_game_event_buffer()
		return
	if _current_processing_questline == null: return
	_current_processing_questline.handle_story_event_advance(next_event)

func _ready():
	var q : Questline = load("res://tst/story/qlines/blacksmith-order-quest.tres")
	active_quests.append(q)
	_current_processing_questline = q
	NarrativeChunkHandler._display_narrative_chunk.call_deferred(q.beginning_event)
	
	CommandServer.register_command(
		CommandBuilder.new()
		.Literal("give-item")
		.Literal("ore")
		.Callback(func():
			NarrativeChunkHandler.process_game_event(GameEventObtainThing.new("Ore"))
			)
		.Build()
	)
