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
	CARGO,
	ENTERTAINMENT,
	HEALTHCARE,
	RECREATION,
	RESIDENTIAL,
	EDUCATION,
}

const ADAPTIVE : Values = Values.ADAPTIVE
const PRODUCTION : Values = Values.PRODUCTION
const CONSUMPTION : Values = Values.CONSUMPTION
const TRANSPORT : Values = Values.TRANSPORT
const DEFENSE : Values = Values.DEFENSE
const SOCIAL : Values = Values.SOCIAL
const UTILITY : Values = Values.UTILITY
const COMMERCE : Values = Values.COMMERCE
const CARGO : Values = Values.CARGO
const ENTERTAINMENT : Values = Values.ENTERTAINMENT
const HEALTHCARE : Values = Values.HEALTHCARE
const RECREATION : Values = Values.RECREATION
const RESIDENTIAL : Values = Values.RESIDENTIAL
const EDUCATION : Values = Values.EDUCATION

func _init(function : Values) -> void:
	self.value = function

func _to_string() -> String:
	return "FunctionTag<%s>" % Values.keys()[self.value]
	
