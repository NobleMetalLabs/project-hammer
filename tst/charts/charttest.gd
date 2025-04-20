extends Control

@onready var holder = $HOLDER

func _ready():
	var chart := DivergingBarChart.new()
	holder.add_child(chart)
	chart.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	chart.values = [
		[1, 1, 7],
		[3, 2, 4],
		[5, 3, 9],
		[2, 4, 6],
		[1, 5, 3],
		[3, 6, 8],
		[2, 7, 5],
		[4, 8, 2],
		[1, 9, 7],
	]
	chart.colors = [
		Color(1, 0, 0),
		Color(0, 1, 0),
		Color(0, 0, 1),
	]
	chart.baseline_index = 2
	chart.update()