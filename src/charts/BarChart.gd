class_name BarChart
extends Chart

var bar_stack : BoxContainer

func _ready():
	bar_stack = BoxContainer.new()
	self.add_child(bar_stack)
	bar_stack.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
