class_name Questline
extends Resource

enum result {
	COMPLETE,
	FAILURE,
}

@export var name : String = ""

@export var beginning_event : StoryEvent = null
@export var objectives : Dictionary = {} #[StoryRelatedEvent, StoryEvent]
@export var next_objectives : Dictionary = {} #[StoryEvent, StoryRelatedEvent]
@export var current_objective : StoryRelatedEvent = null

func _to_string() -> String:
	return "Questline<%s>" % name

func handle_storyreleatedevent(event : StoryRelatedEvent) -> void:
	if current_objective._equals(event):
		ProjectHammerLogger.log(["STORY", "EVENT", "QUEST"], "%s current objective responds to StReEv" % self)
		StoryEventHandler._display_storyevent(objectives[current_objective])
		objectives.erase(current_objective)

func handle_story_event_advance(next_event : StoryEvent) -> void:
	ProjectHammerLogger.log(["STORY", "QUEST", "STORYEVENT"], "%s handling advancement to %s" % [self, next_event])
	if next_objectives.has(next_event):
		current_objective = next_objectives[next_event]
		print("questline objective updated to %s" % current_objective)
		next_objectives.erase(next_event)
	