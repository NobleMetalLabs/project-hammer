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


func weighted_random_index(arg1 = INF, arg2 = INF, arg3 = INF, arg4 = INF, arg5 = INF, arg6 = INF, arg7 = INF, arg8 = INF, arg9 = INF, arg10 = INF, arg11 = INF):
	var weights : Array[float] = []
	for argument in [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11]:
		if argument != INF:
			weights.append(argument)

	var sum : float = 0.0
	for weight in weights:
		sum += weight
	var value : float = randf_range(0, sum)
	for weight_idx in range(0, len(weights)):
		value -= weights[weight_idx]
		if value < 0:
			return weight_idx
