class_name UICrewList
extends Control

@onready var temp_item : Control = self.find_child("ITEM-ROW", true, false)
@onready var slots_label : Label = self.find_child("SLOTS-LABEL", true, false)

signal member_requests_move(member : Crewmember)
signal member_capacity(full : bool, empty : bool)
signal member_selected(member : Crewmember)

var header : StringName = "" :
	set(value):
		print("Header set to: ", value)
		header = value
		var header_label : Label = self.find_child("HEADER-LABEL", true, false)
		header_label.text = header

var max_members : int = 0 :
	set(value):
		max_members = value
		_handle_cap()

var alignment : HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT :
	set(value):
		alignment = value
		temp_item.find_child("CHAR-NAME-LABEL", true, false).horizontal_alignment = alignment
		var mv_bt : Button = temp_item.find_child("MOVE-BUTTON", true, false)
		match(alignment):
			HORIZONTAL_ALIGNMENT_LEFT:
				mv_bt.get_parent().move_child(mv_bt, -1)
				mv_bt.text = " > "
			HORIZONTAL_ALIGNMENT_RIGHT:
				mv_bt.get_parent().move_child(mv_bt, 0)
				mv_bt.text = " < "

var member_items : Dictionary = {} # Dictionary[Crewmember, Control]

func _ready():
	temp_item.hide()
	_handle_cap()

func add_member(member : Crewmember) -> bool:
	if max_members != 0:
		if member_items.size() >= max_members: return false
	var item : Control = temp_item.duplicate()
	temp_item.get_parent().add_child(item)
	item.find_child("CHAR-NAME-LABEL", true, false).text = member.character.name
	item.find_child("MOVE-BUTTON", true, false).pressed.connect(member_requests_move.emit.bind(member))
	item.get_node("ROW-BUTTON").pressed.connect(member_selected.emit.bind(member))
	member_items[member] = item
	item.show()
	_handle_cap()
	return true

func remove_member(member : Crewmember) -> void:
	if member_items.has(member):
		var item : Control = member_items[member]
		item.queue_free()
		member_items.erase(member)
	_handle_cap()

func set_move_enabled(enabled : bool) -> void:
	for item in member_items.values():
		item.find_child("MOVE-BUTTON", true, false).disabled = !enabled

func _handle_cap() -> void:
	if max_members == 0: return
	if slots_label != null:
		slots_label.text = str(member_items.size()) + "/" + str(max_members)
	if member_items.size() >= max_members:
		member_capacity.emit(true, false)
	elif member_items.size() == 0:
		member_capacity.emit(false, true)
	else:
		member_capacity.emit(false, false)
	

