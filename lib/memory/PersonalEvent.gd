class_name PersonalEvent
extends Actor

var subject : Actor
var references : Array[Actor] = []

func _init(_subject : Actor) -> void:
	subject = _subject

func _to_string() -> String:
	if references.is_empty(): return "PersonalEvent: \n" + str(subject) + "\n" + str(tags)
	else: return "PersonalEvent: \n" + str(subject) + "\n" + str(tags) + "\nReferences:\n" + str(references)

# TODO: revise PersonalEvent & TagTree to_strings
