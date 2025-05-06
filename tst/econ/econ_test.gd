extends Node

@onready var MARKET_DATA : TextEdit = $DATA_HOLDER

func render_data():
	MARKET_DATA.text = ""
	log_market_obj_data(self)

func log_market_obj_data(market_item : Node):
	if market_item is MarketParticipant:
		var participant : MarketParticipant = market_item as MarketParticipant
		MARKET_DATA.text += "MarketParticipant\n"
		MARKET_DATA.text += "\tMarket: %s\n" % [ItemDB.item_string(participant.influence.market)]
		MARKET_DATA.text += "\tInfluence Type: %s\n" % [MarketInfluence.InfluenceType.keys()[participant.influence.influence_type]]
		MARKET_DATA.text += "\tValue: %s\n" % [participant.influence.value]
	elif market_item is Reservoir:
		var reservoir : Reservoir = market_item as Reservoir
		MARKET_DATA.text += "Reservoir\n"
		MARKET_DATA.text += "\tType: %s\n" % [ItemDB.item_string(reservoir.reserve.type)]
		MARKET_DATA.text += "\tQuantity: %s\n" % [reservoir.reserve.quantity]
	elif market_item is Producer:
		var producer : Producer = market_item as Producer
		MARKET_DATA.text += "Producer\n"
		if producer.production_status.conversion != null:
			MARKET_DATA.text += "\tConversion:\n"
			for input in producer.production_status.conversion.inputs.keys():
				MARKET_DATA.text += "\t\t%s %s\n" % [producer.production_status.conversion.inputs[input], ItemDB.item_string(input)]
			MARKET_DATA.text += "\t\tmakes:\n"
			for output in producer.production_status.conversion.outputs.keys():
				MARKET_DATA.text += "\t\t%s %s\n" % [producer.production_status.conversion.outputs[output], ItemDB.item_string(output)]
		MARKET_DATA.text += "\tReserves:\n"
		for reserve in producer.production_status.reserves:
			MARKET_DATA.text += "\t\t%s %s\n" % [reserve.quantity, ItemDB.item_string(reserve.type)]
	else	:
		MARKET_DATA.text += market_item.name + "\n"

	for child in market_item.get_children():
		log_market_obj_data(child)

func _ready():
	get_node("OilExtractor/Producer").production_status.reserves.append(
		get_node("TerrestrialPlanet/OilReservoir").reserve
	)
	get_node("WaterExtractor/Producer").production_status.reserves.append(
		get_node("TerrestrialPlanet/WaterReservoir").reserve
	)
	#process_economy()
	print(get_node("OilExtractor/Producer").production_status.reserves)
	render_data()
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			simTick()

func simTick():
	print("simTick runs")
	var requested_oil_amount : float = get_node("OilRefinery/MarketParticipant").influence.value
	print(requested_oil_amount)
	var refinery_producer : Producer = get_node("OilRefinery/Producer")
	var source_reserve : Reserve = null
	for child : Node in self.find_children("*", "", true, false):
		if not child is Reservoir: continue
		var reservoir : Reservoir = child as Reservoir
		if reservoir.reserve.type == ItemDB.Item.RAW_OIL:
			source_reserve = reservoir.reserve
			break
	source_reserve.quantity -= requested_oil_amount
	refinery_producer.production_status.reserves[0].quantity += requested_oil_amount
	process_producer(refinery_producer)
	render_data()

func process_producer(producer : Producer):
	var producer_reserves : Array[Reserve] = producer.production_status.reserves
	var required_inputs : Dictionary = producer.production_status.conversion.inputs
	var outputs : Dictionary = producer.production_status.conversion.outputs
	var can_produce : bool = true
	
	for required_input : ItemDB.Item in required_inputs.keys():
		var reserve_count : int = 0
		for reserve : Reserve in producer_reserves:
			if reserve.type == required_input:
				reserve_count = reserve.quantity
		if reserve_count < required_inputs[required_input]:
			can_produce = false
			break
	if can_produce:
		for required_input : ItemDB.Item in required_inputs.keys():
			for reserve : Reserve in producer_reserves:
				if reserve.type == required_input:
					reserve.quantity -= required_inputs[required_input]
		for output : ItemDB.Item in outputs.keys():
			for reserve : Reserve in producer_reserves:
				if reserve.type == output:
					reserve.quantity += outputs[output]

#func process_economy() -> void:
	#collect_influences()
	#process_supply()
	#process_producers()
	#process_demand()
#
#var influences_by_good : Dictionary = {} # [ItemDB.Item, Array[MarketInfluence]]
#func collect_influences() -> void:
	#influences_by_good.clear()
	#for child in self.get_children():
		#if not child is MarketParticipant: continue
		#var influencer : MarketParticipant = child as MarketParticipant
		#var influence : MarketInfluence = influencer.influence
		#var inf_arr : Array[MarketInfluence] = []
		#influences_by_good.get_or_add(influence.market, inf_arr).append(influence)
#
#var supply_per_good : Dictionary = {} # [ItemDB.Item, float]
#func process_supply() -> void:
	#for good in influences_by_good.keys():
		#var influences : Array[MarketInfluence] = influences_by_good[good]
		#var supply : float = 0.0
		#for influence in influences:
			#if influence.influence_type == MarketInfluence.InfluenceType.SUPPLY:
				#supply += influence.value
		#supply_per_good[good] = supply
#
#var demand_per_good : Dictionary = {} # [ItemDB.Item, float]
#var demand_differential_per_good : Dictionary = {} # [ItemDB.Item, float]
#var price_multiplier_per_good : Dictionary = {} # [ItemDB.Item, float]
#func process_demand() -> void:
	#for good in influences_by_good.keys():
		#var influences : Array[MarketInfluence] = influences_by_good[good]
		#var demand : float = 0.0
		#for influence in influences:
			#if influence.influence_type == MarketInfluence.InfluenceType.DEMAND:
				#demand += influence.value
#
		#demand_per_good[good] = demand
		#var supply : float = supply_per_good.get(good, 0.0)
		#var demand_differential : float = (demand - supply) / supply
		#demand_differential_per_good[good] = demand_differential
		#price_multiplier_per_good[good] = 1.0 + demand_differential
#
	#print("Demand differential per good:")
	#for good in demand_differential_per_good.keys():
		#print("%s: %s" % [ItemDB.Item.keys()[good], demand_differential_per_good[good]])
#
	#print("Price multiplier per good:")
	#for good in price_multiplier_per_good.keys():
		#print("%s: %s" % [ItemDB.Item.keys()[good], price_multiplier_per_good[good]])
#
	#var chart_holder : Control = $"CHART-HOLDER"
	#var chart : DivergingBarChart = DivergingBarChart.new()
	#chart_holder.add_child(chart)
	#
	#var chart_values : Array[Array] = []
	#for good in influences_by_good.keys():
		#chart_values.append([demand_per_good[good], supply_per_good[good]])
	#chart.values = chart_values
	#chart.colors = [
		#Color(1, 0, 0),
		#Color(0, 1, 0),
	#]
	#chart.baseline_index = 1
	#chart.update()
#
#func process_producers() -> void:
	#var producers : Array[Producer] = []
	#for child in self.get_children():
		#if not child is Producer: continue
		#var producer : Producer = child as Producer
		#var production_status : ProductionStatus = producer.production_status

# WHERE REAL COMMENTS BEGIN
		# how much can this producer produce(maximum_production)
			# - market supply (supply)
			# - ingredient reserve (reserves)

		# how much does this producer want to produce (demand_products / conversion_products = production_goal)
			# - (maximum_production)
			# - product reserve (reserves)

		# how much is this producer requiring (conversion_ingredients * current_production)
			# - product_goals

		# how much is this producer producing (current_production)
			# - product_goals

		# how much is this producer supplying (MarketInfleunce.Supply)
			# - how much is this producer producing
			# - product_reserve

		# how much is this producer demanding (MarketInfluence.Demand)
			# - how much is this producer requiring
			# - product_reserve
