class_name WorldGenerator
extends Node

# idea
# func generate_spots_for_location(location : SectorLocation) -> Array[LocationSpot]:
	
	
# 	var spots = Array[LocationSpot]
# 	return spots

func mutate_location_spots(location : SectorLocation) -> SectorLocation:
	if false: # temporary
		pass

	# HEALTHCARE IF NO RECREATION
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) > 2 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RECREATION).Build()) == 0 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.HEALTHCARE).Build()) == 0:
		location.spots.append(SpotBuilder.new().Function(FunctionTag.HEALTHCARE).Build())

	# TRANSPORT IF ENOUGH RESIDENTIAL
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) > 3 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.TRANSPORT).Build()) == 0:
		location.spots.append(SpotBuilder.new().Function(FunctionTag.TRANSPORT).Build())

	# DEFENSE IF ENOUGH COMMERCE
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.COMMERCE).Build()) + \
		count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.PRODUCTION).Build()) + \
		count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.CARGO).Build()) > 4 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.DEFENSE).Build()) == 0:
		location.spots.append(SpotBuilder.new().Function(FunctionTag.DEFENSE).Build())

	# EDUCATION IF ENOUGH RESIDENTIAL
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) > 5 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.TRANSPORT).Build()) > 1 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.EDUCATION).Build()) == 0:
		location.spots.append(SpotBuilder.new().Function(FunctionTag.EDUCATION).Build())

	# RANDOM ADDITIONAL FUNCTION
	elif ProjectHammer.weighted_random_index(1, 12) == 0:
		if location.spots.is_empty(): return
		var spot : LocationSpot = location.spots.pick_random()
		var functiont : FunctionTag = spot.get_tags_of_type("FunctionTag").pop_front()
		match functiont.value:
			FunctionTag.RESIDENTIAL: 
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.SOCIAL,
					FunctionTag.ENTERTAINMENT,
					FunctionTag.HEALTHCARE,
					FunctionTag.RECREATION,
				].pick_random())])
			FunctionTag.CARGO:
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.PRODUCTION,
					FunctionTag.COMMERCE,
				].pick_random())])
			FunctionTag.PRODUCTION:
				Taggable.tag_array_union(spot.tags, [FunctionTag.new(FunctionTag.RESIDENTIAL)])
			FunctionTag.DEFENSE:
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.SOCIAL,
					FunctionTag.RECREATION,
				].pick_random())])
			FunctionTag.SOCIAL: 
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.EDUCATION,
					FunctionTag.COMMERCE,
				].pick_random())])
			FunctionTag.COMMERCE: 
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.PRODUCTION,
					FunctionTag.EDUCATION,
				].pick_random())])
			FunctionTag.RECREATION: 
				Taggable.tag_array_union(spot.tags, [FunctionTag.new(FunctionTag.HEALTHCARE)])
			FunctionTag.TRANSPORT: 
				Taggable.tag_array_union(spot.tags, [FunctionTag.new([
					FunctionTag.DEFENSE,
					FunctionTag.RESIDENTIAL,
					FunctionTag.SOCIAL,
				].pick_random())])

	# HOUSING DEVELOPMENT FAILSAFE
	elif location.spots.size() > count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) * 4:
		match(ProjectHammer.weighted_random_index(75, 25)):
			0: location.spots.append(SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build())
			1: location.spots.pick_random().tags.append(FunctionTag.new(FunctionTag.RESIDENTIAL))

	# RANDOM DEVELOPMENT 3
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) == 3:
		for i in range(0, 1):
			location.spots.append([
				SpotBuilder.new().Function(FunctionTag.HEALTHCARE).Build(),
				SpotBuilder.new().Function(FunctionTag.TRANSPORT).Build(),
				SpotBuilder.new().Function(FunctionTag.ENTERTAINMENT).Build(),
				SpotBuilder.new().Function(FunctionTag.EDUCATION).Build(),
			][ProjectHammer.weighted_random_index(1, 1, 1, 1)]) #TODO: modify weights by faction, race, etc

	# RANDOM DEVELOPMENT 2
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) == 2:
		for i in range(0, 1):
			location.spots.append([
				SpotBuilder.new().Function(FunctionTag.SOCIAL).Build(),
				SpotBuilder.new().Function(FunctionTag.DEFENSE).Build(),
				SpotBuilder.new().Function(FunctionTag.COMMERCE).Build(),
				SpotBuilder.new().Function(FunctionTag.UTILITY).Build(),
			][ProjectHammer.weighted_random_index(15, 10, 8, 10)])

	# RANDOM DEVELOPMENT 1
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) == 1:
		for i in range(0, 1):
			location.spots.append([
				SpotBuilder.new().Function(FunctionTag.SOCIAL).Build(),
				SpotBuilder.new().Function(FunctionTag.PRODUCTION).Item(ItemDB.Item.values().pick_random()).Build(),
				SpotBuilder.new().Function(FunctionTag.COMMERCE).Build(),
				SpotBuilder.new().Function(FunctionTag.RECREATION).Build(),
			][ProjectHammer.weighted_random_index(7, 12, 12, 7)])

	# PRODUCTION
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.CARGO).Build()) == 1 \
	or count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.COMMERCE).Build()) == 1 \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.PRODUCTION).Build()) == 0:
		location.spots.append(
			SpotBuilder.new().Function(FunctionTag.PRODUCTION).Item(ItemDB.Item.values().pick_random()).Build(),
		)
	
	# BASIC HOUSING
	elif location_has_kindred_spot(location, SpotBuilder.new().Function(FunctionTag.CARGO).Build()) \
	and count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) == 0:
		location.spots.append([
			SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build(),
			SpotBuilder.new().Function(FunctionTag.DEFENSE).Function(FunctionTag.RESIDENTIAL).Build(),
		][ProjectHammer.weighted_random_index(90, 10)])

	# BASIC
	elif location.spots.is_empty():
		location.spots.append([
			SpotBuilder.new().Function(FunctionTag.CARGO).Build(),
			SpotBuilder.new().Function(FunctionTag.PRODUCTION).Item(ItemDB.Item.FOOD).Build(),
		][ProjectHammer.weighted_random_index(90, 10)])
		
	
	return location

# TODO: altitudezonetags
# TODO: names
# TODO: descriptions

# note to asoing: you wanted to move this somewhere
func location_has_kindred_spot(location : SectorLocation, match_spot : LocationSpot) -> bool:
	return count_kindred_spots(location, match_spot) > 0

func count_kindred_spots(location : SectorLocation, match_spot : LocationSpot) -> int:
	return location.spots.reduce(
		func is_superset_spot(count, spot):
			if spot.is_superset_of(match_spot, "FunctionTag"):
				return count + 1
			return count 
			, 0)


# temporarily here
class SpotBuilder:
	var spot := LocationSpot.new()
	
	func Function(value : FunctionTag.Values) -> SpotBuilder:
		spot.tags.append(FunctionTag.new(value))
		return self
	
	func Item(value : ItemDB.Item) -> SpotBuilder:
		spot.tags.append(ItemTag.new(value))
		return self
	
	func Build() -> LocationSpot:
		return spot
