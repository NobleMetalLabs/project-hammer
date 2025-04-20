class_name BarChartBar
extends PanelContainer

var _bar_sections : Array[float]	= []
var _bar_colors : Array[Color] = []

var vertical : bool : 
	get: return _section_stack.vertical
	set(value):
		_section_stack.vertical = value
		vertical = value

var flipped : bool = false

# @onready var _base_section : PanelContainer = self.find_child("BAR_SECTION", true, false)
# @onready var _section_stack : BoxContainer = _base_section.get_parent()

@onready var _base_section : PanelContainer
@onready var _section_stack : BoxContainer

func _ready():
	var self_bg := StyleBoxFlat.new()
	self_bg.bg_color = Color.BLACK
	self.add_theme_stylebox_override("panel", self_bg)

	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	self.size_flags_vertical = Control.SIZE_EXPAND_FILL

	_base_section = PanelContainer.new()
	_base_section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_base_section.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var flat_box := StyleBoxFlat.new()
	flat_box.bg_color = Color.WHITE
	_base_section.add_theme_stylebox_override("panel", flat_box)
	
	_section_stack = BoxContainer.new()
	_section_stack.add_theme_constant_override("separation", 0)

	self.add_child(_section_stack)

func set_sections(sections : Array[float]) -> void:
	_bar_sections = sections
	_update()

func set_colors(colors : Array[Color]) -> void:
	_bar_colors = colors
	_update()

func _update() -> void:
	for child in _section_stack.get_children():
		child.queue_free()
	
	var total : float = 0.0
	for i in range(_bar_sections.size()):
		total += _bar_sections[i]
		var section_size : float = _bar_sections[i]
		if section_size <= 0: continue

		var section : PanelContainer = _base_section.duplicate()
		_section_stack.add_child(section)
		if vertical != flipped:
			_section_stack.move_child(section, 0)

		section.size_flags_stretch_ratio = section_size
		if i < _bar_colors.size():
			section.self_modulate = _bar_colors[i]

	if total < 1:
		var empty := Control.new()
		empty.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		empty.size_flags_vertical = Control.SIZE_EXPAND_FILL
		empty.size_flags_stretch_ratio = 1 - total
		_section_stack.add_child(empty)

	


