class_name OutcomeTag
extends EnumTag

enum Values {
	VERY_BAD,
	BAD,
	NEUTRAL,
	GOOD,
	VERY_GOOD,
}

const VERY_BAD : int = Values.VERY_BAD
const BAD : int = Values.BAD
const NEUTRAL : int = Values.NEUTRAL
const GOOD : int = Values.GOOD
const VERY_GOOD : int = Values.VERY_GOOD

func _init(outcome : Values) -> void:
	self.value = outcome

	