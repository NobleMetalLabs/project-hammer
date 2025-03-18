class_name Questline
extends Resource

enum result {
	COMPLETE,
	FAILURE,
}

@export var name : String = ""

@export var beginning_event : NarrativeChunk = null
@export var objectives : Dictionary = {} #[GameEvent, NarrativeChunk]
@export var next_objectives : Dictionary = {} #[NarrativeChunk, Array[GameEvent]]
@export var current_objectives : Array = []

func _to_string() -> String:
	return "Questline<%s>" % name

func handle_game_event(event : GameEvent) -> void:
	for current_objective in current_objectives:
		if current_objective.get_script() != event.get_script(): continue
		if current_objective._equals(event):
			ProjectHammerLogger.log(["STORY", "GAME-EVENT", "QUEST"], "%s current objective responds to GameEvent" % self)
			NarrativeChunkHandler._display_narrative_chunk(objectives[current_objective])
			objectives.erase(current_objective)

func handle_story_event_advance(next_event : NarrativeChunk) -> void:
	ProjectHammerLogger.log(["STORY", "QUEST", "NARRATION"], "%s handling advancement to %s" % [self, next_event])
	if next_objectives.has(next_event):
		current_objectives = next_objectives[next_event]
		ProjectHammerLogger.log(["STORY", "QUEST", "OBJECTIVE"], "%s objectives updated to %s" % [self, current_objectives])
		next_objectives.erase(next_event)
	
