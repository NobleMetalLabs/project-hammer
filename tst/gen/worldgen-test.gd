extends Node

func _ready():
	var wg := WorldGenerator.new()
	var location := SectorLocation.new()

	wg.generate_spots_for_location(location)
	print_spots(location)

func print_spots(location : SectorLocation):
	# Print the spots in the location
	print("-".repeat(30))
	for spot in location.spots:
		print("%s-".repeat(spot.tags.size())%spot.tags)
