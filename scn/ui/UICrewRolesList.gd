class_name UICrewRolesList
extends PanelContainer

@onready var general_role_row : PanelContainer = $"%GENERAL-ROLE-ROW"

var role_rows : Array[PanelContainer] = []
var role_buttons : Array[CheckButton] = []

func _ready() -> void:
	add_roles()
	role_buttons[0].toggled.connect(general_role_toggled)
	reset()

func add_roles() -> void:
	role_rows.push_back(general_role_row)
	role_buttons.push_back(general_role_row.find_child("ROLE-CHECKBUTTON", true, false))
	
	for role_index in Crewmember.Role.keys().size():
		var new_row := general_role_row.duplicate()
		general_role_row.get_parent().add_child(new_row)
		new_row.find_child("ROLE-NAME", true, false).text = Crewmember.Role.keys()[role_index]
		new_row.find_child("ROLE-CHECKBUTTON", true, false).toggled.connect(specific_role_toggled)
		
		role_rows.push_back(new_row)
		role_buttons.push_back(new_row.find_child("ROLE-CHECKBUTTON", true, false))

func reset() -> void:
	role_buttons[0].button_pressed = true

func general_role_toggled(on : bool) -> void:
	if on:
		for i in range(1, role_buttons.size()):
			role_buttons[i].set_pressed_no_signal(false)
		role_buttons[0].disabled = true
	emit()

func specific_role_toggled(on : bool) -> void:
	if on: 
		role_buttons[0].set_pressed_no_signal(false)
		role_buttons[0].disabled = false
	emit()

signal updated_roles(roles : Array[Crewmember.Role])
func emit() -> void:
	var w : Array[Crewmember.Role]
	for button_index in role_buttons.size():
		if role_buttons[button_index].button_pressed: w.push_back(button_index)
	emit_signal("updated_roles", w)

func update_visual(roles : Array[Crewmember.Role]):
	for button_index in role_buttons.size():
		role_buttons[button_index].set_pressed_no_signal(roles.has(button_index))
		role_buttons[0].disabled = roles.has(0)
