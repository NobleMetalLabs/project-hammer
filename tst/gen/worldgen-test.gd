extends Node

func _ready():
	var wg := WorldGenerator.new()
	var sector := WorldSector.new()
	#var location := SectorLocation.new()

	wg.generate_locations_for_sector(sector)
	print_locations(sector)

	#wg.generate_spots_for_location(location)
	#print_spots(location)

func print_locations(sector : WorldSector):
	print("-".repeat(30))
	for location in sector.locations:
		print(location.tags)
		print_sublocations(location)

func print_sublocations(location : SectorLocation, tabs : int = 1):
	for sublocation in location.sublocations:
		var tab_str = "\t".repeat(tabs)
		print(tab_str + str(sublocation.tags).replace("\n", "\n" + tab_str))
		print_sublocations(sublocation, tabs + 1)

func print_spots(location : SectorLocation):
	# Print the spots in the location
	print("-".repeat(30))
	for spot in location.spots:
		print("%s-".repeat(spot.tags.size())%spot.tags)
