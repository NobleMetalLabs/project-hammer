class_name Chart
extends Control

var flipped : bool = false
var bounds_minimum : Vector2 = Vector2(0, 0)
var bounds_maximum : Vector2 = Vector2(0, 0)

func _ready():
	self.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)