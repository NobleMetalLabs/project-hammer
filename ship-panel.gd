extends Panel

@export var ship: Ship
@onready var ship_display : UIShipDisplay = $"%SHIP-DISPLAY"
@onready var system_selection_holder : VBoxContainer = $"SYSTEM-SELECTION-HOLDER"
var selected_system_script : Script

var prev_clicked_coord : Vector3i = Vector3i.MAX

func _ready():
	system_selection_holder.selected_system.connect(func(s):
		selected_system_script = s
	)

	ship_display.input_event_on_ship_grid.connect(handle_input_event_on_ship_grid)

func handle_input_event_on_ship_grid(event : InputEvent, coord : Vector3i):
	if event is InputEventMouseButton and event.pressed:
		if selected_system_script != null:
			var clicked_coord := coord
			if not ship.hull_structure.hull_voxels.has(clicked_coord): 
				selected_system_script = null
				prev_clicked_coord = Vector3i.MAX
				return
			
			if prev_clicked_coord == Vector3i.MAX:
				prev_clicked_coord = clicked_coord
				print("First coord: %s" % prev_clicked_coord)
			else:
				print("Second coord: %s" % clicked_coord)
				try_place_system(selected_system_script.new(), Box3i.from_corners(prev_clicked_coord, clicked_coord))
				prev_clicked_coord = Vector3i.MAX

func try_place_system(system : System, region : Box3i):
	# check if region outside of ship
	for x in range(region.position.x, region.end.x + 1):
		for y in range(region.position.y, region.end.y + 1):
			for z in range(region.position.z, region.end.z + 1):
				if not ship.hull_structure.hull_voxels.has(Vector3i(x,y,z)): 
					print("Couldn't place system: Clips out of the ship")
					return
	
	# check if region overlapping other systems
	for existing_system in ship.installed_systems:
		if region.to_AABB().intersects(existing_system.region.to_AABB()):
			print("Couldn't place system: Intersects existing system %s" % existing_system)
			return
	
	var new_system := InstalledSystem.new(system, region)
	ship.installed_systems.append(new_system)
	
	print("Installed system: %s" % new_system)
