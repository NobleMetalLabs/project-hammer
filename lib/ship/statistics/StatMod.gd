class_name StatMod
extends RefCounted

enum Type {
	FLAT,
	ADD_MULT,
	MULT
}

var mod_type : Type
var value : float

func _init(_type : Type, _value : float):
	mod_type = _type
	value = _value

func _to_string() -> String:
	return "StatMod(%s, %s)" % [mod_type, value]

func as_statline() -> String:
	match mod_type:
		Type.FLAT:
			return "+%s" % value
		Type.ADD_MULT:
			return "+%s%" % value
		Type.MULT:
			return "x%s" % value
	return "???"