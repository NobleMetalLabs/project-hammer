class_name ClimateDiversityTag
extends EnumTag

enum Values {
	NONE,
	UNUSUAL,
	EXTREME,
	MILD,
	REGULAR,
	LOW,
	MINIMAL,
}

const UNUSUAL = Values.UNUSUAL
const EXTREME = Values.EXTREME
const MILD = Values.MILD
const REGULAR = Values.REGULAR
const LOW = Values.LOW
const MINIMAL = Values.MINIMAL

func _init(climate_diversity : Values) -> void:
	self.value = climate_diversity

func _to_string() -> String:
	return "ClimateDiversityTag<%s>" % Values.keys()[self.value]
