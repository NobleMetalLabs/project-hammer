class_name CargoBaySystem
extends System

func  _init():
	name = "Cargo Bay"
	modifies_stats = [
		ProjectHammer.CraftStatistic.CARGO_CAPACITY
	]

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	var mods : Array[StatMod] = []
	mods.append(StatMod.new(StatMod.Type.FLAT, installed.region.get_AABB().get_volume() / 3))
	return mods