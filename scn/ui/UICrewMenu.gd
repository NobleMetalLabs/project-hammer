class_name UICrewMenu
extends Control

#@onready var crew_roles_list : UICrewRolesList = $"%CREW-ROLES-LIST"
@onready var crew_list : UICrewList = $"%CREW-LIST"
@onready var proc_crew_list : UICrewList = $"%PROC-CREW-LIST"

func _ready():
	crew_list.max_members = 5
	proc_crew_list.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	proc_crew_list.header = "PROSPECTS"
	crew_list.member_requests_move.connect(move_member.bind(false))
	proc_crew_list.member_requests_move.connect(move_member.bind(true))
	crew_list.member_capacity.connect(
		func handle_cap(full : bool, _empty : bool) -> void:
			proc_crew_list.set_move_enabled(!full)
	)

	for i in range(0, 12):
		proc_crew_list.add_member(
			Crewmember.new()
		)

func move_member(member : Crewmember, crew_ornah : bool) -> void:
	if crew_ornah:
		if crew_list.add_member(member):
			proc_crew_list.remove_member(member)
	else:
		if proc_crew_list.add_member(member):
			crew_list.remove_member(member)