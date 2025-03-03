class_name InstalledSystem
extends Resource

@export var system : System
@export var region : Box3i

func _init(_system: System, _region: Box3i):
	system = _system
	region = _region

func _to_string() -> String:
	return "InstalledSystem(%s, %s)" % [system, region]
