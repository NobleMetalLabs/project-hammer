class_name BarChart 
extends BoxContainer

var is_horizontal : bool = false :
	set(value):
		is_horizontal = value
		_redraw()

var is_flipped : bool = false :
	set(value):
		is_flipped = value
		_redraw()

var min_value : float = 0.0
var median_value : float = 0.0
var max_value : float = 1.0

var positive_color : Color = Color.WHITE
var negative_color : Color = Color.WHITE

var values : Array[float] = []
var bars : Array[BarChartBar] = []

@onready var temp_bar : BarChartBar = $"%BAR-CHART-BAR"
func _ready():
	temp_bar.hide()

func clear_values() -> void:
	values.clear()
	_redraw()

func add_value(value : float) -> void:
	values.append(value)
	_redraw()

func set_values(new_values : Array[float]) -> void:
	values.clear()
	for value in new_values:
		values.append(value)
	_redraw()

func fit_range_to_values() -> void:
	if values.size() == 0:
		return
	min_value = values.min()
	median_value = min_value
	max_value = values.max()
	_redraw()
	
func _redraw() -> void:
	for bar in bars:
		bar.queue_free()
	bars.clear()

	self.vertical = is_horizontal

	for i in range(0, values.size()):
		var bar : BarChartBar = temp_bar.duplicate()
		add_child(bar)
		bar.show()

		var bar_value : float = values[i]
		if bar_value < median_value:
			bar.flip_bar()
			bar_value = remap(values[i], median_value, min_value, 0, 1)
			bar.modulate = negative_color
		else:
			if bar_value > median_value:
				bar.modulate = positive_color
			bar_value = remap(values[i], median_value, max_value, 0, 1)
		bar.set_value(abs(bar_value))
		if is_horizontal:
			bar.flop_bar()
		if is_flipped:
			bar.flip_bar()
		if min_value != median_value and median_value != max_value:
			bar.show_spacer()
		bars.append(bar)

		