class_name System
extends Resource

var name : StringName = "Unnamed System"
var modifies_stats : Array[ProjectHammer.CraftStatistic] = []

func _init() -> void:
	assert(false, "System is not to be instantiated directly, instantiate a subclass.")

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	assert(false, "get_stat_modifications not implemented for ")
	return []
