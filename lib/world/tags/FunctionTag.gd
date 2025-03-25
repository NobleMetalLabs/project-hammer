class_name FunctionTag
extends EnumTag

enum Values {
	ADAPTIVE,
	PRODUCTION,
	CONSUMPTION,
	TRANSPORT,
	DEFENSE,
	SOCIAL,
	UTILITY,
	COMMERCE,
}

const ADAPTIVE : int = Values.ADAPTIVE
const PRODUCTION : int = Values.PRODUCTION
const CONSUMPTION : int = Values.CONSUMPTION
const TRANSPORT : int = Values.TRANSPORT
const DEFENSE : int = Values.DEFENSE
const SOCIAL : int = Values.SOCIAL
const UTILITY : int = Values.UTILITY
const COMMERCE : int = Values.COMMERCE

func _init(function : Values) -> void:
	self.value = function

	
