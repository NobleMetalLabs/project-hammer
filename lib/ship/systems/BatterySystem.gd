class_name BatterySystem
extends System

func _init():
	name = "Battery"
	modifies_stats = [
		ProjectHammer.CraftStatistic.MAX_BATTERY_CHARGE,
	]

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	var mods : Array[StatMod] = []
	mods.append(StatMod.new(StatMod.Type.FLAT, 10 * installed.manual_efficiency))
	return mods
