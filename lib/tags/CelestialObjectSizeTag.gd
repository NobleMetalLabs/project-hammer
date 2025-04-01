class_name CelestialObjectSizeTag
extends EnumTag

enum Values {
	HUGE,
	LARGE,
	MEDIUM,
	REGULAR,
	SMALL,
	TINY,
}

const HUGE = Values.HUGE
const LARGE = Values.LARGE
const MEDIUM = Values.MEDIUM
const REGULAR = Values.REGULAR
const SMALL = Values.SMALL
const TINY = Values.TINY

func _init(celestial_object_size: Values):
	self.value = celestial_object_size

func _to_string() -> String:
	return "CelestialObjectSizeTag<%s>" % Values.keys()[self.value]
