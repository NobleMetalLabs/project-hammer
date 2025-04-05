extends Control

@onready var new_button : Button = $"%NEW-BUTTON"

@onready var char_info_label : Label = $"%CHARACTER-INFO-LABEL"
@onready var char_asl_stack : BoxContainer = $"%ASL-STACK"
@onready var char_asl_label : Label = char_asl_stack.get_child(0)

@onready var char_skills_chart : BarChart = $"%SKILLS-CHART"
@onready var char_ethics_chart : BarChart = $"%ETHICS-CHART"

func _ready():
	char_asl_label.hide()
	char_skills_chart.is_horizontal = true

	char_ethics_chart.is_horizontal = true
	char_ethics_chart.min_value = -1
	char_ethics_chart.median_value = 0
	char_ethics_chart.max_value = 1
	char_ethics_chart.positive_color = Color.GREEN.lightened(0.5)
	char_ethics_chart.negative_color = Color.RED.lightened(0.5)

	new_button.pressed.connect(
		func () -> void:
			display_character_info(Character.new())
	)

func display_character_info(char : Character) -> void:
	char_info_label.text = char.name
	_set_asl(char)

	var values : Array[float] = []
	values.assign(char.skills.get_skill_value_dictionary().values())
	char_skills_chart.set_values(values)

	values.clear()
	values.assign(char.ethics.get_principle_value_dictionary().values())
	char_ethics_chart.set_values(values)

func _set_asl(char : Character) -> void:
	for child in char_asl_stack.get_children():
		if child == char_asl_label: continue
		child.queue_free()
	
	var info_dict : Dictionary = {
		"RACE" : Character.Race.keys()[char.race],
		"SEX" : "YES",
		"GENDER" : char.gender,
	}
	for info_name in info_dict.keys():
		var l1 : Label = char_asl_label.duplicate()
		var l2 : Label = char_asl_label.duplicate()
		char_asl_stack.add_child(l1)
		char_asl_stack.add_child(l2)
		l1.text = info_name + ":"
		l2.text = str(info_dict[info_name])
		l1.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		l2.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		l1.show()
		l2.show()
