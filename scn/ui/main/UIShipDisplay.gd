class_name UIShipDisplay
extends Control

@onready var grid_holder : Control = $"%GRID-HOLDER"
@onready var grid_square : TextureRect = grid_holder.get_child(0)

func _ready():
	grid_holder.remove_child(grid_square)

const grid_size : int = 32
var current_z_layer : int = 0

signal input_event_on_ship_grid(event : InputEvent, coord : Vector3i)

func _gui_input(event):
	var coord := Vector3i.MAX
	if event.get("position") != null:
		var grid_space_pos : Vector2 = event.position - grid_holder.position
		var grid_pos : Vector2i = grid_space_pos / grid_size
		coord = Vector3i(grid_pos.x, grid_pos.y, current_z_layer)
	input_event_on_ship_grid.emit(event, coord)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed and Input.is_key_pressed(KEY_SHIFT):
		if event.keycode == KEY_W:
			current_z_layer += 1
			get_tree().get_root().set_input_as_handled()
			return
		elif event.keycode == KEY_S:
			current_z_layer -= 1
			get_tree().get_root().set_input_as_handled()
			return

func _process(_delta):
	for child in grid_holder.get_children():
		child.queue_free()

	var hull_size : Vector2i = Vector2i.ZERO

	for voxel_position : Vector3i in ShipManager.ship.hull_structure.hull_voxels:
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
