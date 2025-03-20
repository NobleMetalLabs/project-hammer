class_name NarrativeChunkTree
extends Tree

func _ready():
	self.item_activated.connect(func handle_activated():
		var obj = _tree_item_to_obj[get_selected()]
		if obj is NarrativeChoice:
			_add_chunk_to_selected_choice()
		elif obj is NarrativeChunk:
			_convert_selected_chunk_to_choice()
	)

func _input(event):
	if Input.is_action_just_pressed("ui_text_delete"):
		_delete_selected()

var _tree_item_to_obj : Dictionary = {}
var _obj_to_tree_item : Dictionary = {}

func _build_tree(root_chunk : NarrativeChunk) -> void:
	var root = self.create_item()
	self.hide_root = true
	self.set_column_expand(0, true)
	self.set_column_expand(1, false)
	_tree_build_chunk_section(root_chunk, root)

func _tree_build_chunk_section(chunk : NarrativeChunk, parent : TreeItem = null) -> void:
	var chunk_item : TreeItem = _obj_to_tree_item.get(chunk, null)
	var existing : bool = chunk_item != null
	if not existing: chunk_item = self.create_item(parent)
	_tree_item_to_obj[chunk_item] = chunk
	_obj_to_tree_item[chunk] = chunk_item
	var text = chunk.description
	if text.length() > 15: text = text.left(15) + "..."
	chunk_item.set_text(0, text)
	if existing: return
	if chunk.next_chunk != null:
		_tree_build_chunk_section(chunk.next_chunk, parent)
	elif chunk is NarrativeChoiceChunk:
		for choice in chunk.choices:
			_tree_build_choice_section(choice, chunk_item)

func _tree_build_choice_section(choice : NarrativeChoice, parent : TreeItem = null) -> void:
	var choice_item : TreeItem = _obj_to_tree_item.get(choice, null)
	var existing : bool = choice_item != null
	if not existing: choice_item = self.create_item(parent)
	_tree_item_to_obj[choice_item] = choice
	_obj_to_tree_item[choice] = choice_item
	choice_item.set_text(0, choice.text)
	if not existing:
		_tree_build_chunk_section(choice.resulting_narrative, choice_item)

func _convert_selected_chunk_to_choice() -> void:
	var selected_item = self.get_selected()
	if selected_item == null: return
	var selected_obj = _tree_item_to_obj[selected_item]
	if not selected_obj is NarrativeChunk: return

	var choice_chunk := NarrativeChoiceChunk.new()
	choice_chunk.description = selected_obj.description
	choice_chunk.result_description = selected_obj.result_description
	choice_chunk.result_commands = selected_obj.result_commands
	selected_obj = choice_chunk

	var new_choice = NarrativeChoice.new()
	_tree_build_choice_section(new_choice, selected_item)

func _add_chunk_to_selected_choice() -> void:
	var selected_item = self.get_selected()
	if selected_item == null: return
	var selected_obj = _tree_item_to_obj[selected_item]
	if not selected_obj is NarrativeChoice: return

	var new_chunk = NarrativeChunk.new()
	_tree_build_chunk_section(new_chunk, selected_item)

func _delete_selected() -> void:
	var selected_item = self.get_selected()
	if selected_item == null: return
	var selected_obj = _tree_item_to_obj[selected_item]
	if selected_obj == null: return
	_tree_item_to_obj.erase(selected_item)
	_obj_to_tree_item.erase(selected_obj)
	selected_item.free()

signal tree_restructured()

# https://forum.godotengine.org/t/dragging-treeitems-within-tree-control-node/42393
func _get_drag_data(_at_position: Vector2) -> Variant:
	var selected_item : TreeItem = get_next_selected(null)
	if selected_item == null: return null
	var selected_object : Variant = _tree_item_to_obj.get(selected_item)

	# var v := VBoxContainer.new()
	# var l := Label.new()
	# l.text = "  %s" % selected.get_text(0)
	# v.add_child(l)
	# set_drag_preview(v)
	return selected_item

# chunk >< chunks
# choice >< choices

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var source_item : TreeItem = data
	if source_item.get_tree() != self: return false
	var source_object : Variant = _tree_item_to_obj.get(source_item)
	if source_object == null: return false
	drop_mode_flags = Tree.DROP_MODE_INBETWEEN
	var target_item : TreeItem = get_item_at_position(at_position)
	var target_object : Variant = _tree_item_to_obj.get(target_item)
	if target_object == null: return false
	var target_destination : int = get_drop_section_at_position(at_position)
	if target_destination == -100: return false
	if source_object is NarrativeChunk:
		if target_object is NarrativeChoice: return target_destination == 1
		return true
	elif source_object is NarrativeChoice:
		if target_object is NarrativeChoiceChunk: return target_destination == 1
		elif target_object is NarrativeChunk: return false
		return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var source_item : TreeItem = data
	var source_object : Variant = _tree_item_to_obj.get(source_item)
	if source_object == null: return
	var target_item : TreeItem = get_item_at_position(at_position)
	var target_object : Variant = _tree_item_to_obj.get(target_item)
	var target_destination : int = get_drop_section_at_position(at_position)
	if target_object == null: return
	match target_destination:
		-100, 0: return
		-1: source_item.move_before(target_item)
		1: 
			if target_object is NarrativeChoice != source_object is NarrativeChoice:
				source_item.move_before(target_item.get_first_child())
			else:
				source_item.move_after(target_item)
	tree_restructured.emit()


