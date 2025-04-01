class_name WorldGenerator
extends Node

func generate_locations_for_sector(sector : WorldSector) -> WorldSector:
	for i in range(8):
		pass
		#var 
	
	return sector

func generate_location_for_sector(sector : WorldSector) -> WorldSector:
	var objects := CelestialObjectTag.Values.values()
	var celestial_object : CelestialObjectTag.Values = objects[ProjectHammer.weighted_random_index(60, 16, 12, 7, 3, 1, 1, 0)]
	
	var location := LocationBuilder.new().CelestialObject(celestial_object).Build()
	if ProjectHammer.weighted_random_index(1, 1) == 0:
		match(celestial_object):
			CelestialObjectTag.MOON:
				var valid_objects_to_hook : Array[SectorLocation] = sector.locations.filter(func(loc : SectorLocation):
					return loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.PLANET).Build())
					)
				if not valid_objects_to_hook.is_empty():
					valid_objects_to_hook.pick_random().sublocations.append(location)
					
			CelestialObjectTag.SHIP: 
				sector.locations.pick_random().sublocations.append(location)
			CelestialObjectTag.SPACE_STATION:
				# 💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
				var valid_objects_to_hook : Array[SectorLocation] = sector.locations.filter(func(loc : SectorLocation):
					return loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.PLANET).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.MOON).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.ASTEROID).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.ANOMALY).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.STAR).Build())\
					)
				if not valid_objects_to_hook.is_empty():
					valid_objects_to_hook.pick_random().sublocations.append(location)
					
			CelestialObjectTag.ASTEROID: 
				var valid_objects_to_hook : Array[SectorLocation] = sector.locations.filter(func(loc : SectorLocation):
					return loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.PLANET).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.MOON).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.SPACE_STATION).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.ANOMALY).Build())\
					or loc.is_superset_of(LocationBuilder.new().CelestialObject(CelestialObjectTag.Values.STAR).Build())\
					)
				if not valid_objects_to_hook.is_empty():
					valid_objects_to_hook.pick_random().sublocations.append(location)
			CelestialObjectTag.ANOMALY:
				sector.locations.pick_random().sublocations.append(location)
			
			CelestialObjectTag.PLANET, CelestialObjectTag.COMET, CelestialObjectTag.STAR, _: pass
			
			
	
	return sector

# TODO: these functions below are really more like "generate spots for city"
# locations should be able to have cities (essentially spot groups)
# examples - cities on the planet, or a city on its orbiting bodies (moon; space station)
# also - locations can be individual bodies (moon; ship; space station; asteroid; comet; anomaly👽)
#						(planet is 60)	[60, 16,   12, 		7				3		1		1	]

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

class LocationBuilder:
	var location := SectorLocation.new()
	
	func CelestialObject(value : CelestialObjectTag.Values) -> LocationBuilder:
		location.tags.append(CelestialObjectTag.new(value))
		return self
	
	func Build() -> SectorLocation:
		return location
