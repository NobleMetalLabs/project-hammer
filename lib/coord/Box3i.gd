class_name Box3i
extends Resource

@export var position : Vector3i :
	set(value):
		position = value
		size = end - position
@export var size: Vector3i :
	set(value):
		size = value
		end = position + size
var end : Vector3i :
	set(value):
		end = value
		size = end - position

func _init(_position: Vector3i = Vector3i.ZERO, _size: Vector3i = Vector3i.ZERO):
	position = _position
	size = _size

static func from_AABB(aabb: AABB) -> Box3i:
	return Box3i.new(aabb.position, aabb.size)

func to_AABB() -> AABB:
	return AABB(position, size)
	