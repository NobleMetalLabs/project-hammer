extends Node

@export var tex : Texture2D
@onready var img : Image = tex.get_image()
var hull_str : HullStructure

func _ready() -> void:
	hull_str = HullStructure.new()

	for y in range(img.get_height()):
		for x in range(img.get_width()):
			var color = img.get_pixel(x, y)
			color = color * color.a
			if color.r > 0:
				hull_str.hull_voxels.append(Vector3i(x, y, 0))
			if color.g > 0:
				hull_str.hull_voxels.append(Vector3i(x, y, 1))
			if color.b > 0:
				hull_str.hull_voxels.append(Vector3i(x, y, 2))

	var box = $CSGBox3D
	self.remove_child(box)

	for position : Vector3i in hull_str.hull_voxels:
		var new_box := box.duplicate()
		new_box.position = position * Vector3i(1, -1, 1)
		self.add_child(new_box)

	ResourceSaver.save(hull_str, "res://little.tres")