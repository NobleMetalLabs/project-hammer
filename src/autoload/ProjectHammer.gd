#class_name ProjectHammer
extends Node

enum CraftStatistic {
	#Modifiable stats
	AUGMENT_SLOTS,
	PERSONNEL_CAPACITY,
	CARGO_CAPACITY,
	CARGO_TRANSFER_SPEED,
	MASS,
	ENGINE_THRUST,
	THRUSTER_THRUST,
	ENERGY_PRODUCTION,
	ENERGY_DEMAND,
	MAX_BATTERY_CHARGE,
	#Dependant stats
	BATTERY_CHARGE,
	ENERGY_SATISFACTION,
	SYSTEM_EFFICIENCY,
}

func craft_stat_string(stat : CraftStatistic) -> StringName:
	return CraftStatistic.keys()[stat].replace("_", " ")

func craft_stat_units(stat : CraftStatistic) -> StringName:
	match(stat):
		CraftStatistic.MASS, \
		CraftStatistic.CARGO_CAPACITY \
		: return "m³"
		CraftStatistic.ENERGY_PRODUCTION, \
		CraftStatistic.ENERGY_DEMAND \
		: return "e"
		CraftStatistic.MAX_BATTERY_CHARGE, \
		CraftStatistic.BATTERY_CHARGE \
		: return "e/t"
		CraftStatistic.ENERGY_SATISFACTION, \
		CraftStatistic.SYSTEM_EFFICIENCY \
		: return "%"
		CraftStatistic.CARGO_TRANSFER_SPEED \
		: return "m³/t"
		CraftStatistic.ENGINE_THRUST, \
		CraftStatistic.THRUSTER_THRUST \
		: return "N"
		_: return ""