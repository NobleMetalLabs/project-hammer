class_name TestEnergyLoadSystem
extends System

func  _init():
	name = "TestLoad"
	modifies_stats = [
		ProjectHammer.CraftStatistic.ENERGY_DEMAND,
	]

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	var mods : Array[StatMod] = []
	if Input.is_key_pressed(KEY_L):
		mods.append(StatMod.new(StatMod.Type.FLAT, 12 * installed.manual_efficiency))
	else:
		mods.append(StatMod.new(StatMod.Type.FLAT, 4 * installed.manual_efficiency))
	return mods
