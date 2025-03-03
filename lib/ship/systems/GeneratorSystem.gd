class_name GeneratorSystem
extends System

func  _init():
	name = "Generator"
	modifies_stats = [
		ProjectHammer.CraftStatistic.ENERGY_PRODUCTION,
	]

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	var mods : Array[StatMod] = []
	mods.append(StatMod.new(StatMod.Type.FLAT, 10))
	return mods