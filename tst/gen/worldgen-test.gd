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
	var occupied_offsets : Array[Vector2] = []
	
	for location : SectorLocation in sector.locations:
		var celestial_object : CelestialObjectTag.Values = location.get_tags_of_type("CelestialObjectTag")[0].value
		var object_sprite := Sprite2D.new()
		
		match(celestial_object):
			CelestialObjectTag.STAR:
				object_sprite.texture = load("res://tst/gen/location-ast/star.png")
				# goofy
				var startag_str = str(location.get_tags_of_type("StarColorTag")[0])
				var starcolor = startag_str.substr(startag_str.find("<") + 1, -1).trim_suffix(">")
				object_sprite.self_modulate = Color(starcolor)
			CelestialObjectTag.PLANET:
				object_sprite.texture = load("res://tst/gen/location-ast/planet.png")
				# give position spaced away from others
				while(not spawned_appropriately_spaced(object_sprite.offset, occupied_offsets, 800)):
					object_sprite.offset = Vector2(randi_range(-1600, 1600), randi_range(-1600, 1600))
				
				# should be linear in reality
				object_sprite.scale *= (1.0/(location.get_tags_of_type("CelestialObjectSizeTag")[0].value + 1))
				
				
		
		occupied_offsets.append(object_sprite.offset)
		if central_sprite == null: 
			central_sprite = object_sprite
			$MapCenter.add_child(central_sprite)
		else:
			central_sprite.add_child(object_sprite)

func spawned_appropriately_spaced(pos : Vector2, avoid : Array[Vector2], minimum_distance : int) -> bool:
	for bp in avoid: if bp.distance_to(pos) <= minimum_distance: return false
	return true

var central_sprite : Sprite2D = null
func _process(delta: float) -> void:
	for sprite : Sprite2D in central_sprite.get_children():
		sprite.rotation += PI/8 * delta # / (sprite.offset.distance_squared_to(Vector2.ZERO))
