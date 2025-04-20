extends Control

@onready var holder = $HOLDER

func _ready():
	var chart := DivergingBarChart.new()
	holder.add_child(chart)
	chart.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	chart.values = [
		[1, 1],
		[3, 2],
		[5, 3],
		[2, 4],
		[1, 5],
		[3, 6],
		[2, 7],
		[4, 8],
		[1, 9],
	]
	chart.colors = [
		Color(1, 0, 0),
		Color(0, 1, 0),
	]
	chart.baseline_index = 1
	chart.update()



	var line := Line2D.new()
	holder.add_child(line)
	line.antialiased = true
	line.width = 4
	line.joint_mode = Line2D.LineJointMode.LINE_JOINT_BEVEL
	line.begin_cap_mode = Line2D.LineCapMode.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LineCapMode.LINE_CAP_ROUND
	
	var points : Array = []
	for pair in chart.values:
		points.append(pair[1] - pair[0])
	#points.assign([-1, 2, -3, 4, -5, 6, -7, 8, -9])
	print(points)
	var bounds_min : float = chart.bounds_minimum.y
	var bounds_max : float = chart.bounds_maximum.y
	print(bounds_min, bounds_max)
	var line_points : Array[Vector2] = []
	for i in range(points.size()):
		var x : float = (float(i) / points.size()) * chart.size.x + (chart.size.x / points.size() / 2)
		var y : float = remap(points[i], bounds_min, bounds_max, 1, 0) * chart.size.y
		line_points.append(Vector2(x, y))
	line.points = line_points