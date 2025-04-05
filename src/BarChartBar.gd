class_name BarChartBar
extends Container

var stack : BoxContainer
var progress_bar : ProgressBar
var spacer : Control

func _ready():
	stack = find_child("_", true, false)
	for child in stack.get_children():
		if child is ProgressBar:
			progress_bar = child
		else:
			spacer = child

func set_value(value : float) -> void:
	progress_bar.value = value

func show_spacer() -> void:
	spacer.visible = true
	
func flip_bar() -> void:
	stack.move_child(stack.get_child(-1), 0)
	match(progress_bar.fill_mode):
		ProgressBar.FILL_BEGIN_TO_END:
			progress_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN
		ProgressBar.FILL_END_TO_BEGIN:
			progress_bar.fill_mode = ProgressBar.FILL_BEGIN_TO_END
		ProgressBar.FILL_BOTTOM_TO_TOP:
			progress_bar.fill_mode = ProgressBar.FILL_TOP_TO_BOTTOM
		ProgressBar.FILL_TOP_TO_BOTTOM:
			progress_bar.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP

func flop_bar() -> void:
	stack.vertical = !stack.vertical
	stack.move_child(stack.get_child(-1), 0)
	match(progress_bar.fill_mode):
		ProgressBar.FILL_END_TO_BEGIN:
			progress_bar.fill_mode = ProgressBar.FILL_TOP_TO_BOTTOM
		ProgressBar.FILL_BEGIN_TO_END:
			progress_bar.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP
		ProgressBar.FILL_BOTTOM_TO_TOP:
			progress_bar.fill_mode = ProgressBar.FILL_BEGIN_TO_END
		ProgressBar.FILL_TOP_TO_BOTTOM:
			progress_bar.fill_mode = ProgressBar.FILL_END_TO_BEGIN