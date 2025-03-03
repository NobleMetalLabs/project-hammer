class_name BotCargoBaySystem
extends CargoBaySystem

func  _init():
	name = "Bot Bay"
	modifies_stats = [
		ProjectHammer.CraftStatistic.CARGO_CAPACITY,
		ProjectHammer.CraftStatistic.CARGO_TRANSFER_SPEED,
		ProjectHammer.CraftStatistic.ENERGY_DEMAND,
	]

func get_stat_modifications(stat : ProjectHammer.CraftStatistic, installed : InstalledSystem, ship : Ship) -> Array[StatMod]:
	var mods : Array[StatMod] = []
	match(stat):
		ProjectHammer.CraftStatistic.CARGO_CAPACITY:
			mods.append(StatMod.new(StatMod.Type.FLAT, installed.region.get_AABB().get_volume() / 1.1))
		ProjectHammer.CraftStatistic.CARGO_TRANSFER_SPEED:
			var energy_sat : float = ship.get_statistic(ProjectHammer.CraftStatistic.SYSTEM_EFFICIENCY)
			mods.append(
				StatMod.new(
					StatMod.Type.MULT, 2 * energy_sat
				)
			)
		# ProjectHammer.CraftStatistic.CREW_RISK:
		# 	mods.append(StatMod.new(StatMod.Type.MULT, 0))
		ProjectHammer.CraftStatistic.ENERGY_DEMAND:
			mods.append(StatMod.new(StatMod.Type.FLAT, -100.0))

	return mods