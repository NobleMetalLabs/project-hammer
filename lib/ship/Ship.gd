class_name Ship
extends Resource

@export var name : StringName
@export var hull_structure : HullStructure
@export var installed_systems : Array[InstalledSystem]
@export var installed_augments : Array[InstalledAugment]

@export var onboard_crew : Array[Crewmember]
@export var onboard_cargo : Array[Cargo]
@export var onboard_passengers : Array[Passenger]

var _dependant_stats : Dictionary = {} #[ProjectHammer.CraftStatistic, float]

func get_statistic(stat : ProjectHammer.CraftStatistic) -> float:
	if _dependant_stats.has(stat):
		return _dependant_stats[stat]
	var value : float = 0.0
	var stat_mods : Array[StatMod] = []
	for inst_system in installed_systems:
		var system : System = inst_system.system
		if system.modifies_stats.has(stat):
			stat_mods.append_array(system.get_stat_modifications(stat, inst_system, self))
	# TODO: also do augments
	stat_mods.sort_custom(_sort_mods_custom)
	for mod in stat_mods:
		match mod.mod_type:
			StatMod.Type.FLAT:
				value += mod.value
			StatMod.Type.ADD_MULT:
				value *= 1 + mod.value
			StatMod.Type.MULT:
				value *= mod.value
	return value

func set_statistic(stat : ProjectHammer.CraftStatistic, value : float) -> void:
	_dependant_stats[stat] = value
	
func _sort_mods_custom(a : StatMod, b : StatMod) -> int:
	return int(a.mod_type) > int(b.mod_type)

func do_simulation_tick() -> void:
	var energy_production : float = get_statistic(ProjectHammer.CraftStatistic.ENERGY_PRODUCTION)
	var energy_demand : float = get_statistic(ProjectHammer.CraftStatistic.ENERGY_DEMAND)
	var energy_differential : float = energy_production - energy_demand
	var battery_charge : float = get_statistic(ProjectHammer.CraftStatistic.BATTERY_CHARGE)
	var battery_production : float = min(battery_charge, -energy_differential)
	battery_charge -= battery_production
	set_statistic(ProjectHammer.CraftStatistic.BATTERY_CHARGE, battery_charge)
	var energy_satisfaction : float = 1 + ((energy_differential  + battery_production) / energy_demand)
	set_statistic(ProjectHammer.CraftStatistic.ENERGY_SATISFACTION, energy_satisfaction)
	
