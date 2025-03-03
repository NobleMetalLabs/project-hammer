extends Control

@export var ship : Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t := Timer.new()
	t.wait_time = 1.5
	t.timeout.connect(update)
	add_child(t)
	t.start()

func update() -> void:
	ship.do_simulation_tick()

	print("w")

	$"%GENLB".text = "GENERATED POWER: %s" % [ship.get_statistic(ProjectHammer.CraftStatistic.ENERGY_PRODUCTION)]
	$"%DEMLB".text = "DEMANDED POWER: %s" % [ship.get_statistic(ProjectHammer.CraftStatistic.ENERGY_DEMAND)]
	$"%CHRLB".text = "BATTERY CHARGE: %s" % [ship.get_statistic(ProjectHammer.CraftStatistic.BATTERY_CHARGE)]
	$"%SATLB".text = "ENERGY SATISFACTION: %s" % [ship.get_statistic(ProjectHammer.CraftStatistic.ENERGY_SATISFACTION)]