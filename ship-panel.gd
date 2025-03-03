extends Panel

@export var ship: Ship

@export var current_z_layer : int = 0

@onready var grid_holder : Control = $"%GRID-HOLDER"
@onready var grid_square : TextureRect = grid_holder.get_child(0)

var prev_clicked_coord : Vector3i = Vector3i.MAX

func _ready():
	grid_holder.remove_child(grid_square)

const grid_size : int = 32

func _input(event):
	if event is InputEventMouse:
		var ev_pos : Vector2 = event.position
		var grid_space_pos : Vector2 = ev_pos - grid_holder.global_position
		var grid_pos : Vector2i = grid_space_pos / grid_size
		#print("%s | %s | %s" % [ev_pos, grid_space_pos, grid_pos])
		
		if event is InputEventMouseButton and event.pressed:
			var clicked_coord := Vector3i(grid_pos.x, grid_pos.y, current_z_layer)
			if not ship.hull_structure.hull_voxels.has(clicked_coord): return
			
			if prev_clicked_coord == Vector3i.MAX:
				prev_clicked_coord = clicked_coord
				print("First coord: %s" % prev_clicked_coord)
			else:
				print("Second coord: %s" % clicked_coord)
				try_place_system(GeneratorSystem.new(), Box3i.from_corners(prev_clicked_coord, clicked_coord))
				prev_clicked_coord = Vector3i.MAX
		
	elif event is InputEventKey:
		if event.pressed and Input.is_key_pressed(KEY_SHIFT):
			if event.keycode == KEY_W:
				current_z_layer += 1
			elif event.keycode == KEY_S:
				current_z_layer -= 1

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

func _process(_delta):
	for child in grid_holder.get_children():
		child.queue_free()

	var hull_size : Vector2i = Vector2i.ZERO

	for voxel_position : Vector3i in ship.hull_structure.hull_voxels:
		hull_size = hull_size.max(Vector2i(voxel_position.x, voxel_position.y))
		if voxel_position.z < current_z_layer: continue
		if voxel_position.z > current_z_layer + 1: continue
		
		var grid_square_instance = grid_square.duplicate()
		grid_square_instance.custom_minimum_size = Vector2i.ONE * grid_size
		grid_square_instance.size = Vector2i.ONE * grid_size
		grid_square_instance.position = Vector2(voxel_position.x, voxel_position.y) * grid_size
		if voxel_position.z > current_z_layer: 
			grid_square_instance.self_modulate = Color(1, 1, 1, 0.5)
		grid_holder.add_child(grid_square_instance)

	grid_holder.custom_minimum_size = hull_size * grid_size
	
