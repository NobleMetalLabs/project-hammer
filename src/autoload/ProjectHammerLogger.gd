#class_name ProjectHammerLogger
extends Node

var tags : Array[String] = [
	"story",
	"emergent",
	"quest",
	"narration",
	"ethics",
	"game-event",
	"ui",
]

var tag_colors : Dictionary = {
	"story" : "BLUE",
	"emergent" : "DARK_TURQUOISE",
	"quest" : "CORNFLOWER_BLUE",
	"narration" : "DARK_CYAN",
	"ethics" : "CYAN",
	"game-event" : "GREY",
	"ui" : "GREEN",
}

@export var tag_visibility : Dictionary = {
	"story" : true,
	"emergent" : true,
	"quest" : true,
	"narration" : true,
	"ethics" : true,
	"game-event" : true,
	"ui" : true,
}

func log(message_tags : Array[String], message : String) -> void:
	for tag : String in message_tags:
		if not tag_visibility.get(tag.to_lower(), true): 
			return

	var complete_message : String = "%s %s" % [_build_tagchain(message_tags), message]
	print_rich(complete_message)

func error(message : String) -> void:
	push_error("%s" % message)

func _build_tagchain(chain_tags : Array[String]) -> String:
	var out : Array[String] = []
	if chain_tags.size() > 0:
		chain_tags.insert(0, "PROJ-HAMMER")
	for tag : String in chain_tags:
		var tag_key : String = tag.to_lower()
		out.append("[color=%s][%s][/color]" % [tag_colors.get(tag_key, "white"), tag_key.to_upper()])
	return "".join(out)
	