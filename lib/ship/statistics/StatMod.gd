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
