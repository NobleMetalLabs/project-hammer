class_name AltitudeZoneTag
extends EnumTag

enum Values {
	EMPTY_SPACE,
	STELLAR_ORBIT,
	BODY_ORBIT,
	HIGH,
	MID,
	AVERAGE,
	LOW,
	SEA,
	BELOW_SEA,
	BELOW_GROUND,
}

const EMPTY_SPACE : Values = Values.EMPTY_SPACE
const STELLAR_ORBIT : Values = Values.STELLAR_ORBIT
const BODY_ORBIT : Values = Values.BODY_ORBIT
const HIGH : Values = Values.HIGH
const MID : Values = Values.MID
const AVERAGE : Values = Values.AVERAGE
const LOW : Values = Values.LOW
const SEA : Values = Values.SEA
const BELOW_SEA : Values = Values.BELOW_SEA
const BELOW_GROUND : Values = Values.BELOW_GROUND

func _init(altitude_zone : Values) -> void:
	self.value = altitude_zone

func _to_string() -> String:
	return "AltitudeZoneTag<%s>" % Values.keys()[self.value]
