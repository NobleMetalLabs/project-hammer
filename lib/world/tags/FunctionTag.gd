class_name FunctionTag
extends EnumTag

enum Values {
	ADAPTIVE,
	PRODUCTION,
	CONSUMPTION,
	TRANSPORT,
	DEFENSE,
	OFFENSE,
	UTILITY,
}

const ADAPTIVE : int = Values.ADAPTIVE
const PRODUCTION : int = Values.PRODUCTION
const CONSUMPTION : int = Values.CONSUMPTION
const TRANSPORT : int = Values.TRANSPORT
const DEFENSE : int = Values.DEFENSE
const OFFENSE : int = Values.OFFENSE
const UTILITY : int = Values.UTILITY

func _init(function : Values) -> void:
	self.value = function

	