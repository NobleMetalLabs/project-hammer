class_name PerceptionTag
extends EnumTag

enum Values {
	VERY_BAD,
	BAD,
	NEUTRAL,
	GOOD,
	VERY_GOOD,
}

const VERY_BAD : Values = Values.VERY_BAD
const BAD : Values = Values.BAD
const NEUTRAL : Values = Values.NEUTRAL
const GOOD : Values = Values.GOOD
const VERY_GOOD : Values = Values.VERY_GOOD

func _init(perception : Values) -> void:
	self.value = perception
