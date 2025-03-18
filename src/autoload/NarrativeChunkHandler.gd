#class_name NarrativeChunkHandler
extends Node

var _story_event_occurrences : Dictionary = {} #[GameEvent, NarrativeChunk]

func register_narrative_chunk_occurence(related_event : GameEvent, event : NarrativeChunk) -> void:
	_story_event_occurrences[related_event] = event

func deregister_narrative_chunk_occurence(related_event : GameEvent) -> void:
	_story_event_occurrences.erase(related_event)

func process_game_event(related_event : GameEvent) -> void:

	ProjectHammerLogger.log(["STORY", "GAME-EVENT"], "Processing %s" % related_event)
	ProjectHammerLogger.log(["STORY", "GAME-EVENT", "EMERGENT"], "Does event trigger any emergent NarrativeChunks?")
	if _story_event_occurrences.has(related_event):
		var emergent_event : NarrativeChunk = _story_event_occurrences[related_event]
		ProjectHammerLogger.log(["STORY", "GAME-EVENT", "EMERGENT"], "Triggering event %s" % emergent_event)
		_display_narrative_chunk(emergent_event)

	ProjectHammerLogger.log(["STORY", "GAME-EVENT", "QUEST"], "Does event trigger any questline advancements?")
	QuestlineManager.handle_story_related_event(related_event)

signal display_narrative_chunk(event : NarrativeChunk) #TODO: better word than "display"

func _display_narrative_chunk(event : NarrativeChunk) -> void:
	ProjectHammerLogger.log(["STORY", "NARRATION"], "Triggering %s" % event)
	display_narrative_chunk.emit(event)
	QuestlineManager.handle_story_event_advance.call(event)
	if event == null: return # TODO: dont tell ui to display null just check for null and tell it to hide
	
	for command in event.result_commands:
		CommandServer.run_command(command)

func handle_story_event_advance(next_event : NarrativeChunk) -> void:
	_display_narrative_chunk(next_event)
