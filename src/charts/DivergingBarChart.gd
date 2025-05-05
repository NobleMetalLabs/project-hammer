class_name DivergingBarChart
extends BarChart

var values : Array[Array] = []
var colors : Array[Color] = []
var baseline_index : int = 0

func _ready():
	super()

func update() -> void:
	# Clear existing bars
	for bar in bar_stack.get_children():
		bar.queue_free()

	# Chunk row values to sums
	var row_sums_negative : Array[float] = []
	var row_sums_positive : Array[float] = []
	for row_idx in range(values.size()):
		var row_sum_negative : float = 0
		var row_sum_positive : float = 0
		for row_value_idx in range(values[row_idx].size()):
			if row_value_idx < baseline_index:
				row_sum_negative += values[row_idx][row_value_idx]
			else:
				row_sum_positive += values[row_idx][row_value_idx]
		row_sums_negative.push_back(row_sum_negative)
		row_sums_positive.push_back(row_sum_positive)

	# Get data bounds
	bounds_minimum = Vector2(0, -row_sums_negative.max())
	bounds_maximum = Vector2(values.size(), row_sums_positive.max())

	# Create new bars based on values
	for row_idx in range(values.size()):
		var bar := BarChartBar.new()
		bar_stack.add_child(bar)
		bar.vertical = true
		bar.flipped = self.flipped

		var row_values : Array[float] = []
		row_values.assign(values[row_idx])
		if -bounds_minimum.y > 0:
			row_values.push_front(-bounds_minimum.y - row_sums_negative[row_idx])
		else:
			row_values = row_values.slice(baseline_index)
		if bounds_maximum.y > 0:
			row_values.push_back(bounds_maximum.y - row_sums_positive[row_idx])
		else:
			row_values = row_values.slice(0, baseline_index + 1)

		var row_colors : Array[Color] = []
		row_colors.assign(colors)
		if -bounds_minimum.y > 0:
			row_colors.push_front(Color.TRANSPARENT)
		else:
			row_colors = row_colors.slice(baseline_index)
		if bounds_maximum.y > 0:
			row_colors.push_back(Color.TRANSPARENT)
		else:
			row_colors = row_colors.slice(0, baseline_index + 1)

		bar.set_sections(row_values)
		bar.set_colors(row_colors)

# TODO: not filling properly when values dont range from 0 to 1
