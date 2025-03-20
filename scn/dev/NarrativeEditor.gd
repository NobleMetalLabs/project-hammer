class_name NarrativeEditor
extends Control

@export var editing_narrative_root : NarrativeChunk = null

@onready var chunk_editing_vbox : VBoxContainer = $"%CHUNK-EDITING"
@onready var narrative_text_edit : TextEdit = $"%NARRATIVE-TEXT-EDIT"
@onready var result_text_edit : TextEdit = $"%RESULT-TEXT-EDIT"
@onready var command_text_edit : TextEdit = $"%COMMAND-TEXT-EDIT"

@onready var choice_editing_vbox : VBoxContainer = $"%CHOICE-EDITING"
@onready var choice_text_edit : LineEdit = $"%TEXT-LINE-EDIT"

@onready var chunk_tree : NarrativeChunkTree = $"%CHUNK-TREE"

func _ready():
	chunk_tree._build_tree(editing_narrative_root)
	_edit_narrative_chunk(editing_narrative_root)

	chunk_tree.cell_selected.connect(func handle_selected():
		var obj = chunk_tree._tree_item_to_obj[chunk_tree.get_selected()]
		if obj is NarrativeChunk:
			_edit_narrative_chunk(obj)
		elif obj is NarrativeChoice:
			_edit_narrative_choice(obj)
	)

	chunk_tree.tree_restructured.connect(_save_chunk_structure)

var _current_obj : Object = null
func _edit_narrative_chunk(chunk : NarrativeChunk) -> void:
	_save_narrative_chunk()
	_save_narrative_choice()
	_current_obj = chunk
	if _current_obj == null: return
	choice_editing_vbox.hide()
	chunk_editing_vbox.show()
	narrative_text_edit.text = _current_obj.description
	result_text_edit.text = _current_obj.result_description
	command_text_edit.text = "\n".join(_current_obj.result_commands)

func _save_narrative_chunk() -> void:
	if _current_obj == null: return
	if not _current_obj is NarrativeChunk: return
	_current_obj.description = narrative_text_edit.text
	_current_obj.result_description = result_text_edit.text
	_current_obj.result_commands.assign(command_text_edit.text.split("\n"))
	chunk_tree._tree_build_chunk_section(_current_obj)

func _edit_narrative_choice(choice : NarrativeChoice) -> void:
	_save_narrative_chunk()
	_save_narrative_choice()
	_current_obj = choice
	if _current_obj == null: return
	chunk_editing_vbox.hide()
	choice_editing_vbox.show()
	choice_text_edit.text = _current_obj.text

func _save_narrative_choice() -> void:
	if _current_obj == null: return
	if not _current_obj is NarrativeChoice: return
	_current_obj.text = choice_text_edit.text
	chunk_tree._tree_build_choice_section(_current_obj)

func _save_chunk_structure() -> void:
	editing_narrative_root = _build_chunk_chain(chunk_tree.get_root().get_child(0))

func _build_chunk_chain(start_item : TreeItem) -> NarrativeChunk:
	var start_chunk : NarrativeChunk = chunk_tree._tree_item_to_obj[start_item]
	var current_item : TreeItem = start_item
	while current_item != null:
		var prev_item : TreeItem = current_item 
		var prev_obj : Object = chunk_tree._tree_item_to_obj[prev_item]
		current_item = current_item.get_next()
		var item_obj : Object = chunk_tree._tree_item_to_obj.get(current_item, null)
		prev_obj.next_chunk = item_obj
		if current_item == null: break
		if current_item.get_child_count() > 0:
			item_obj.choices = _build_choices(current_item)
	return start_chunk

func _build_choices(choice_chunk_item : TreeItem) -> Array[NarrativeChoice]:
	var choices : Array[NarrativeChoice] = []
	for choice_item in choice_chunk_item.get_children():
		var choice_obj : NarrativeChoice = chunk_tree._tree_item_to_obj[choice_item]
		choice_obj.resulting_narrative = _build_chunk_chain(choice_item.get_child(0))
		choices.append(choice_obj)
	return choices
