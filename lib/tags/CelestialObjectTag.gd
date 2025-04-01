class_name CelestialObjectTag
extends EnumTag

enum Values {
	PLANET,
	MOON,
	SHIP,
	SPACE_STATION,
	ASTEROID,
	COMET,
	ANOMALY,
	STAR,
}

const PLANET = Values.PLANET
const MOON = Values.MOON
const SHIP = Values.SHIP
const SPACE_STATION = Values.SPACE_STATION
const ASTEROID = Values.ASTEROID
const COMET = Values.COMET
const ANOMALY = Values.ANOMALY
const STAR = Values.STAR

func _init(celestial_object : Values) -> void:
	self.value = celestial_object

func _to_string() -> String:
	return "CelestialObjectTag<%s>" % Values.keys()[self.value]
