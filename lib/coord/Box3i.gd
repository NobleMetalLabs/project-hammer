class_name Box3i
extends Resource

@export var position : Vector3i
@export var size: Vector3i
var end : Vector3i :
	get:
		return position + size - Vector3i.ONE
	set(value):
		size = value - position + Vector3i.ONE

func _init(_position: Vector3i = Vector3i.ZERO, _size: Vector3i = Vector3i.ZERO):
	position = _position
	size = _size

static func from_corners(corner1: Vector3i, corner2: Vector3i) -> Box3i:
	var box := Box3i.new()
	box.position = corner1.min(corner2)
	box.end = corner1.max(corner2)
	return box

static func from_AABB(aabb: AABB) -> Box3i:
	return Box3i.new(aabb.position, aabb.size)

func to_AABB() -> AABB:
	return AABB(position, size)

func _to_string() -> String:
	return "Box3i(%s, %s)" % [position, size]
