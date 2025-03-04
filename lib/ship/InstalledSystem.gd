class_name InstalledSystem
extends Resource

@export var system : System
@export var region : Box3i

@export_range(0, 200, 1, "suffix:%") \
var manual_efficiency_percent : float = 100.0

static func _new(_system: System, _region: Box3i) -> InstalledSystem:
	var inst_system := InstalledSystem.new()
	inst_system.system = _system
	inst_system.region = _region
	return inst_system

func _to_string() -> String:
	return "InstalledSystem(%s, %s)" % [system, region]
