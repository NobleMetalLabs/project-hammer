class_name StarColorTag
extends EnumTag

enum Values {
	BLUE,
	WHITE,
	YELLOW,
	ORANGE,
	RED,
	BLACK,
}

const BLUE = Values.BLUE
const WHITE = Values.WHITE
const YELLOW = Values.YELLOW
const ORANGE = Values.ORANGE
const RED = Values.RED
const BLACK = Values.BLACK

func _init(star_color : Values) -> void:
	self.value = star_color

func _to_string() -> String:
	return "StarColorTag<%s>" % Values.keys()[self.value]
