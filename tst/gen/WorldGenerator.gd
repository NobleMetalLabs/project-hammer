class_name WorldGenerator
extends Node

#region Sector Generation
func generate_locations_for_sector(sector : WorldSector) -> WorldSector:
	if ProjectHammer.weighted_random_index(5, 1) == 0:
		sector.locations.append(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.STAR).Build())

	for i in range(8):
		generate_location_for_sector(sector)
	
	return sector

func generate_location_for_sector(sector : WorldSector) -> WorldSector:
	var objects := CelestialObjectTag.Values.values()
	# TODO: rules (type maximums) to prevent dull sectors?
	var celestial_object : CelestialObjectTag.Values = objects[ProjectHammer.weighted_random_index(60, 30, 20, 10, 7, 3, 0.1, 0)]
	
	var location := LocationBuilder.new().CelestialObject(celestial_object).Build()
	var dont_hook_odds : float = 0
	match(celestial_object):
		CelestialObjectTag.PLANET, CelestialObjectTag.COMET, CelestialObjectTag.STAR: dont_hook_odds = 0
		CelestialObjectTag.ANOMALY, CelestialObjectTag.SPACE_STATION: dont_hook_odds = 10
		CelestialObjectTag.ASTEROID: dont_hook_odds = 4
		CelestialObjectTag.MOON: dont_hook_odds = 0.05
		CelestialObjectTag.SHIP: dont_hook_odds = 0.66

	if ProjectHammer.weighted_random_index(1, dont_hook_odds) == 0:
		var valid_objects_to_hook : Array[SectorLocation] = []
		match(celestial_object):
			CelestialObjectTag.MOON:
				valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
					Taggable.is_superset_of.bind(
						LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.PLANET).Build()
					)
				))

			CelestialObjectTag.SPACE_STATION:
				valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
					Taggable.is_intersection_not_empty.bind(LocationBuilder.new()
						.CelestialObject(CelestialObjectTag.Values.PLANET)
						.CelestialObject(CelestialObjectTag.Values.MOON)
						.CelestialObject(CelestialObjectTag.Values.ASTEROID)
						.CelestialObject(CelestialObjectTag.Values.ANOMALY)
						.CelestialObject(CelestialObjectTag.Values.STAR)
					.Build())
				))
					
			CelestialObjectTag.ASTEROID: 
				valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
					Taggable.is_intersection_not_empty.bind(LocationBuilder.new()
						.CelestialObject(CelestialObjectTag.Values.PLANET)
						.CelestialObject(CelestialObjectTag.Values.MOON)
						.CelestialObject(CelestialObjectTag.Values.SPACE_STATION)
						.CelestialObject(CelestialObjectTag.Values.ANOMALY)
						.CelestialObject(CelestialObjectTag.Values.STAR)
					.Build())
				))

			CelestialObjectTag.SHIP:
				valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
					Taggable.is_intersection_empty.bind(LocationBuilder.new()
						.CelestialObject(CelestialObjectTag.Values.SHIP)
					.Build())
				))
			
			CelestialObjectTag.ANOMALY:
				valid_objects_to_hook = sector.locations_with_sublocations
			
			CelestialObjectTag.PLANET, CelestialObjectTag.COMET, CelestialObjectTag.STAR, _: pass
		
		if not valid_objects_to_hook.is_empty():
			valid_objects_to_hook.pick_random().sublocations.append(location)
			return sector

	sector.locations.append(location)
	return sector
#endregion

#region Location Generation

# TODO: make other location generation strategies
# locations should be able group output of citygen (LocationSpotGroup)

#region Cities
func generate_spots_for_location(location : SectorLocation) -> SectorLocation:
	for i in range(8): # range should be determined by location
		mutate_location_spots(location)
	
	assign_spot_altitudes(location)
	
	return location

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
			location.spots.append(SpotBuilder.new().Function([
					FunctionTag.HEALTHCARE,
					FunctionTag.TRANSPORT,
					FunctionTag.ENTERTAINMENT,
					FunctionTag.EDUCATION,
				][ProjectHammer.weighted_random_index(1, 1, 1, 1)])
			.Build()) #TODO: modify weights by faction, race, etc

	# RANDOM DEVELOPMENT 2
	elif count_kindred_spots(location, SpotBuilder.new().Function(FunctionTag.RESIDENTIAL).Build()) == 2:
		for i in range(0, 1):
			location.spots.append(SpotBuilder.new().Function([
				FunctionTag.SOCIAL,
				FunctionTag.DEFENSE,
				FunctionTag.COMMERCE,
				FunctionTag.UTILITY,
				][ProjectHammer.weighted_random_index(15, 10, 8, 10)])
			.Build())

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

func assign_spot_altitudes(location : SectorLocation) -> SectorLocation:
	var altitude_values := AltitudeZoneTag.Values.values()
	var avg_altitude : AltitudeZoneTag.Values = altitude_values[ProjectHammer.weighted_random_index(0, 0, 0, 1, 5, 7, 5, 3, 1, 0.25)]
	
	for spot : LocationSpot in location.spots:
		var offset = [-2, -1, 0, 1, 2][ProjectHammer.weighted_random_index(1, 5, 7, 5, 1)]
		var altitude : AltitudeZoneTag.Values = clampi(avg_altitude + offset, 0, altitude_values.size() - 1) as AltitudeZoneTag.Values
		spot.tags.append(AltitudeZoneTag.new(altitude))
	
	return location

# TODO: names
# TODO: descriptions

# note to asoing: you wanted to move this somewhere
func location_has_kindred_spot(location : SectorLocation, match_spot : LocationSpot) -> bool:
	return count_kindred_spots(location, match_spot) > 0

func count_kindred_spots(location : SectorLocation, match_spot : LocationSpot) -> int:
	return location.spots.filter(Taggable.is_superset_of.bind(match_spot, "FunctionTag")).size()

#endregion
#endregion

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

class LocationBuilder:
	var location := SectorLocation.new()
	
	func CelestialObject(value : CelestialObjectTag.Values) -> LocationBuilder:
		location.tags.append(CelestialObjectTag.new(value))
		return self
	
	func Build() -> SectorLocation:
		return location
