extends Node

func _ready():
	var influences_by_good : Dictionary = {} # [ItemDB.Item, Array[MarketInfluence]]
	for influencer in self.get_children():
		if not influencer is MarketParticipant: continue
		var influence : MarketInfluence = influencer.influence
		var inf_arr : Array[MarketInfluence] = []
		influences_by_good.get_or_add(influence.market, inf_arr).append(influence)

	var demand_per_good : Dictionary = {} # [ItemDB.Item, float]
	var supply_per_good : Dictionary = {} # [ItemDB.Item, float]
	var demand_differential_per_good : Dictionary = {} # [ItemDB.Item, float]
	var price_multiplier_per_good : Dictionary = {} # [ItemDB.Item, float]
	for good in influences_by_good.keys():
		var influences : Array[MarketInfluence] = influences_by_good[good]
		var supply : float = 0.0
		var demand : float = 0.0
		for influence in influences:
			if influence.influence_type == MarketInfluence.InfluenceType.SUPPLY:
				supply += influence.value
			elif influence.influence_type == MarketInfluence.InfluenceType.DEMAND:
				demand += influence.value

		demand_per_good[good] = demand
		supply_per_good[good] = supply
		var demand_differential : float = (demand - supply) / supply
		demand_differential_per_good[good] = demand_differential
		price_multiplier_per_good[good] = 1.0 + demand_differential

	print("Demand differential per good:")
	for good in demand_differential_per_good.keys():
		print("%s: %s" % [ItemDB.Item.keys()[good], demand_differential_per_good[good]])

	print("Price multiplier per good:")
	for good in price_multiplier_per_good.keys():
		print("%s: %s" % [ItemDB.Item.keys()[good], price_multiplier_per_good[good]])

	var chart_holder : Control = $"CHART-HOLDER"
	var chart : DivergingBarChart = DivergingBarChart.new()
	chart_holder.add_child(chart)
	
	var chart_values : Array[Array] = []
	for good in influences_by_good.keys():
		chart_values.append([demand_per_good[good], supply_per_good[good]])
	chart.values = chart_values
	chart.colors = [
		Color(1, 0, 0),
		Color(0, 1, 0),
	]
	chart.baseline_index = 1
	chart.update()
