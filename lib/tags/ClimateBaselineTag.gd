class_name ClimateBaselineTag
extends EnumTag

enum Values {
	NONE,
	VOLCANIC,
	ARID,
	HOT,
	REGULAR,
	COLD,
	ARCTIC,
	TROPIC,
	OCEAN,
}

func _init(climate_baseline : Values) -> void:
	self.value = climate_baseline

func _to_string() -> String:
	return "ClimateBaselineTag<%s>" % Values.keys()[self.value]
