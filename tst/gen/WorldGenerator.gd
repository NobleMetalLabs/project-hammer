class_name WorldGenerator
extends Node

#region Sector Generation
func generate_locations_for_sector(sector : WorldSector) -> WorldSector:
	if ProjectHammer.weighted_random_index(5, 1) == 0:
		var new_loc := SectorLocation.new()
		sector.locations.append(new_loc)
		new_loc.tags.add_fan([
			Tag.CelestialObjectTypeStar,
			Tag.StarColor + 1 + ProjectHammer.weighted_random_index(1, 2, 7, 5, 1, 0.25),
		])

	for i in range(8):
		generate_location_for_sector(sector)

	determine_sublocations_for_sector(sector)
	assign_location_climates(sector)
	
	return sector

func generate_location_for_sector(sector : WorldSector) -> WorldSector:
	# TODO: rules (type maximums) to prevent dull sectors?
	var new_loc := SectorLocation.new()
	sector.locations.append(new_loc)
	new_loc.tags.add_fan([
		Tag.CelestialObjectType + 1 + ProjectHammer.weighted_random_index(60, 30, 20, 10, 7, 3, 0.1, 0),
		Tag.CelestialObjectSize + 1 + ProjectHammer.weighted_random_index(0.25, 3, 5, 7, 5, 1),
	])
	return sector

func determine_sublocations_for_sector(sector : WorldSector) -> WorldSector:
	for location : SectorLocation in sector.locations.duplicate():
		var celestial_object_type : int = location.tags.get_tag_of_type(Tag.CelestialObjectType)
		var dont_hook_odds : float = 0
		match(celestial_object_type):
			Tag.CelestialObjectTypePlanet, Tag.CelestialObjectTypeComet, Tag.CelestialObjectTypeStar: dont_hook_odds = 0
			Tag.CelestialObjectTypeAnomaly, Tag.CelestialObjectTypeSpaceStation: dont_hook_odds = 10
			Tag.CelestialObjectTypeAsteroid: dont_hook_odds = 4
			Tag.CelestialObjectTypeMoon: dont_hook_odds = 0.05
			Tag.CelestialObjectTypeShip: dont_hook_odds = 0.66

		if ProjectHammer.weighted_random_index(1, dont_hook_odds) == 0:
			var valid_objects_to_hook : Array[SectorLocation] = []
			match(celestial_object_type):
				Tag.CelestialObjectTypeMoon:
					valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
						TagTree.actor_has.bind(Tag.CelestialObjectTypePlanet)
					))

				Tag.CelestialObjectTypeSpaceStation:
					valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
						TagTree.actor_has_any.bind([
							Tag.CelestialObjectTypePlanet,
							Tag.CelestialObjectTypeMoon,
							Tag.CelestialObjectTypeAsteroid,
							Tag.CelestialObjectTypeAnomaly,
							Tag.CelestialObjectTypeStar,
						])
					))
						
				Tag.CelestialObjectTypeAsteroid: 
					valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
						TagTree.actor_has_any.bind([
							Tag.CelestialObjectTypePlanet,
							Tag.CelestialObjectTypeMoon,
							Tag.CelestialObjectTypeSpaceStation,
							Tag.CelestialObjectTypeAnomaly,
							Tag.CelestialObjectTypeStar,
						])
					))

				Tag.CelestialObjectTypeShip:
					valid_objects_to_hook.assign(sector.locations_with_sublocations.filter(
						TagTree.actor_not_has.bind(Tag.CelestialObjectTypeShip)
					))
				
				Tag.CelestialObjectTypeAnomaly:
					valid_objects_to_hook = sector.locations_with_sublocations
				
				Tag.CelestialObjectTypePlanet, Tag.CelestialObjectTypeComet, Tag.CelestialObjectTypeStar, _: pass
			
			if not valid_objects_to_hook.is_empty():
				valid_objects_to_hook.pick_random().sublocations.append(location)
				sector.locations.erase(location)

	return sector

func assign_location_climates(sector : WorldSector) -> WorldSector:
	for location : SectorLocation in sector.locations:
		var climate_baseline : int = Tag.ClimateBaseline + 1 + ProjectHammer.weighted_random_index(0, 1, 3, 4, 5, 4, 4, 2)
		var climate_diversity : int = Tag.ClimateDiversity + 1 + ProjectHammer.weighted_random_index(0, 0.25, 1, 5, 7, 5, 1)
		
		match(location.tags.get_tag_of_type(Tag.CelestialObjectType)):
			Tag.CelestialObjectTypePlanet: pass
			Tag.CelestialObjectTypeMoon:
				climate_baseline = Tag.ClimateBaselineNone
				climate_diversity = Tag.ClimateDiversityNone
			_:
				continue

		location.tags.add_fan([climate_baseline, climate_diversity])
	
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
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidence])) > 2 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptRecreation])) == 0 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptHealthcare])) == 0:
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.tag_chain([Tag.RelationshipFunction, Tag.ConceptHealthcare])

	# TRANSPORT IF ENOUGH RESIDENTIAL
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) > 3 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptTransport])) == 0:
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.tag_chain([Tag.RelationshipFunction, Tag.ConceptTransport])

	# DEFENSE IF ENOUGH COMMERCE
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCommerce])) + \
		count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptProduction])) + \
		count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCargo])) > 4 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptDefense])) == 0:
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.tag_chain([Tag.RelationshipFunction, Tag.ConceptDefense])

	# EDUCATION IF ENOUGH RESIDENTIAL
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) > 5 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptTransport])) > 1 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptEducation])) == 0:
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.tag_chain([Tag.RelationshipFunction, Tag.ConceptEducation])

	# RANDOM ADDITIONAL FUNCTION
	elif ProjectHammer.weighted_random_index(1, 12) == 0:
		if location.spots.is_empty(): return
		var spot : LocationSpot = location.spots.pick_random()
		if spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])):
			spot.tags.add_chain([Tag.RelationshipFunction, Tag.ConceptEducation, Tag.ConceptEngineering])
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptSocial, 
					Tag.ConceptEntertainment, 
					Tag.ConceptHealthcare, 
					Tag.ConceptRecreation
				].pick_random()
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCargo])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptProduction, 
					Tag.ConceptCommerce
				].pick_random()
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptProduction])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				Tag.ConceptResidential
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptDefense])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptSocial, 
					Tag.ConceptRecreation
				].pick_random()
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptSocial])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptEducation, 
					Tag.ConceptCommerce
				].pick_random()
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCommerce])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptProduction, 
					Tag.ConceptEducation
				].pick_random()
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptRecreation])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				Tag.ConceptHealthcare
			])
		elif spot.tags.has_tree(TagTree.chain([Tag.RelationshipFunction, Tag.ConceptTransport])):
			spot.tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptDefense, 
					Tag.ConceptResidential, 
					Tag.ConceptSocial
				].pick_random()
			])

	# HOUSING DEVELOPMENT FAILSAFE
	elif location.spots.size() > count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) * 4:
		var target : LocationSpot = location.spots.pick_random()
		if ProjectHammer.weighted_random_index(25, 75):
			target = LocationSpot.new()
			location.spots.append(target)
		target.tags.add_chain([Tag.RelationshipFunction, Tag.ConceptResidential])

	# RANDOM DEVELOPMENT 3
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) == 3:
		for i in range(0, 1):
			location.spots.append(LocationSpot.new().tags.add_chain([
					Tag.RelationshipFunction, 
					[
						Tag.ConceptHealthcare,
						Tag.ConceptTransport,
						Tag.ConceptEntertainment,
						Tag.ConceptEducation,
					][ProjectHammer.weighted_random_index(1, 1, 1, 1)] #TODO: modify weights by faction, race, etc
			]))

	# RANDOM DEVELOPMENT 2
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) == 2:
		for i in range(0, 1):

			location.spots.append(LocationSpot.new().tags.add_chain([
				Tag.RelationshipFunction, 
				[
					Tag.ConceptSocial,
					Tag.ConceptDefense,
					Tag.ConceptCommerce,
					Tag.ConceptUtility,
				][ProjectHammer.weighted_random_index(15, 10, 8, 10)]
			]))

	# RANDOM DEVELOPMENT 1
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) == 1:
		for i in range(0, 1):
			var new_loc := LocationSpot.new()
			location.spots.append(new_loc)
			new_loc.tags.add_chain(
				[
					[Tag.RelationshipFunction, Tag.ConceptSocial],
					[Tag.RelationshipFunction, Tag.ConceptProduction, Tag.Item + ItemDB.Item.values().pick_random()],
					[Tag.RelationshipFunction, Tag.ConceptCommerce],
					[Tag.RelationshipFunction, Tag.ConceptRecreation],
				][ProjectHammer.weighted_random_index(7, 12, 12, 7)]
			)

	# PRODUCTION
	elif count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCargo])) == 1 \
	or count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCommerce])) == 1 \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptProduction])) == 0:
		location.spots.append(
			[Tag.RelationshipFunction, Tag.ConceptProduction, Tag.Item + ItemDB.Item.values().pick_random()],
		)
	
	# BASIC HOUSING
	elif location_has_kindred_spot(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptCargo])) \
	and count_kindred_spots(location, TagTree.chain([Tag.RelationshipFunction, Tag.ConceptResidential])) == 0:
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.add_chain(
			[
				[Tag.RelationshipFunction, Tag.ConceptResidential],
				[Tag.RelationshipFunction, Tag.ConceptDefense, Tag.ConceptResidential],
			][ProjectHammer.weighted_random_index(90, 10)]
		)

	# BASIC
	elif location.spots.is_empty():
		var new_loc := LocationSpot.new()
		location.spots.append(new_loc)
		new_loc.tags.add_chain(
			[
				[Tag.RelationshipFunction, Tag.ConceptCargo],
				[Tag.RelationshipFunction, Tag.ConceptProduction, Tag.Item + ItemDB.Item.FOOD],
			][ProjectHammer.weighted_random_index(90, 10)]
		)
		
	return location

func assign_spot_altitudes(location : SectorLocation) -> SectorLocation:
	var avg_altitude : int  = Tag.AltitudeZone + 1 +  ProjectHammer.weighted_random_index(0, 0, 0, 1, 5, 7, 5, 3, 1, 0.25)
	
	for spot : LocationSpot in location.spots:
		var offset = [-2, -1, 0, 1, 2][ProjectHammer.weighted_random_index(1, 5, 7, 5, 1)]
		var altitude : int = clampi(avg_altitude + offset, Tag.AltitudeZone, Tag.get_tag_type_num_values(Tag.AltitudeZone) - 1)
		spot.tags.add_tag(altitude)
	
	return location

# TODO: names
# TODO: descriptions

# note to asoing: you wanted to move this somewhere
func location_has_kindred_spot(location : SectorLocation, tag_tree : TagTree) -> bool:
	return count_kindred_spots(location, tag_tree) > 0

func count_kindred_spots(location : SectorLocation, tag_tree : TagTree) -> int:
	return location.spots.filter(TagTree.actor_has.bind(tag_tree)).size()

#endregion
#endregion