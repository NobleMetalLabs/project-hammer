extends Node

func _ready():
	var wg := WorldGenerator.new()
	var sector := WorldSector.new()
	#var location := SectorLocation.new()

	wg.generate_locations_for_sector(sector)
	print_locations(sector)

	#wg.generate_spots_for_location(location)
	#print_spots(location)
	
	test_draw_sector(sector)



func print_locations(sector : WorldSector):
	print("-".repeat(30))
	for location in sector.locations:
		print("%s-".repeat(location.tags.size())%location.tags)
		print_sublocations(location)

func print_sublocations(location : SectorLocation, tabs : int = 1):
	for sublocation in location.sublocations:
		print("\t".repeat(tabs) + "%s-".repeat(sublocation.tags.size())%sublocation.tags)
		print_sublocations(sublocation, tabs + 1)

func print_spots(location : SectorLocation):
	# Print the spots in the location
	print("-".repeat(30))
	for spot in location.spots:
		print("%s-".repeat(spot.tags.size())%spot.tags)

# extremely temp just fing around mostly
func test_draw_sector(sector: WorldSector):
	var center : Vector2 = get_viewport().size / 2
	
	for location : SectorLocation in sector.locations:
		var celestial_object : CelestialObjectTag.Values = location.get_tags_of_type("CelestialObjectTag")[0].value
		var object_rect := ColorRect.new()
		
		match(celestial_object):
			CelestialObjectTag.STAR:
				object_rect.position = center - Vector2(100,100)
				object_rect.size = Vector2(200,200) 
				
				# goofy
				var startag_str = str(location.get_tags_of_type("StarColorTag")[0])
				var starcolor = startag_str.substr(startag_str.find("<") + 1, -1).trim_suffix(">")
				object_rect.color = Color(starcolor)
		
		$maptest.add_child(object_rect)
