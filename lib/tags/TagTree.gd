class_name TagTree
extends Resource

var _tags : Dictionary = {} #[int, Dictionary[...]]

var _curr_target : Dictionary = _tags
var _last_target : Dictionary = _tags
var _perm_target : Dictionary = _tags

func _to_string() -> String:
	return _dict_to_string(_tags)

func _dict_to_string(target : Dictionary, tabs = 0) -> String:
	if target.is_empty(): return "d"
	var output : String = ""
	for tag in target.keys():
		output += "\t".repeat(tabs) + Tag.get_tag_name(tag)
		var new_target : Dictionary = target[tag]
		if new_target.is_empty():
			output += "\n"
		else:
			output += "\n" + _dict_to_string(new_target, tabs + 1)
	return output

func get_tag_of_type(tag_id : int) -> int:
	for tag in _tags.keys():
		if Tag.is_tag_of_type(tag, tag_id):
			return tag
	return -1

func add_tag(tag_id : int) -> TagTree:
	if _curr_target.has(tag_id): return
	_curr_target[tag_id] = {}
	_last_target = _curr_target[tag_id]
	_curr_target = _perm_target
	return self

func add_fan(tags : PackedInt32Array) -> TagTree:
	var target : Dictionary = _curr_target
	for tag in tags:
		add_tag(tag)
		_curr_target = target
	_curr_target = _perm_target
	return self

func add_chain(tags : PackedInt32Array) -> TagTree:
	for tag in tags:
		add_tag(tag)
		deep()
	_curr_target = _perm_target
	return self

func deep() -> TagTree:
	_curr_target = _last_target
	return self

func hold_deep() -> TagTree:
	_perm_target = _last_target
	deep()
	return self

func unhold() -> TagTree:
	_perm_target = _tags
	return self

func has(tag_id : int) -> bool:
	return _tags.has(tag_id)

func not_has(tag_id : int) -> bool:
	return not _tags.has(tag_id)

func has_any(tags : PackedInt32Array) -> bool:
	for tag in tags:
		if _tags.has(tag):
			return true
	return false

func has_tree(tree : TagTree) -> bool:
	return _target_has_tree(_tags, tree._tags)

func _target_has_tree(target : Dictionary, tree : Dictionary) -> bool:
	for tag in tree.keys():
		if target.has(tag):
			if tree[tag].is_empty():
				return true
			elif _target_has_tree(target[tag], tree[tag]):
				return true
	return false

static func chain(tags : PackedInt32Array) -> TagTree:
	var tree : TagTree = TagTree.new()
	tree.add_chain(tags)
	return tree

static func fan(tags : PackedInt32Array) -> TagTree:
	var tree : TagTree = TagTree.new()
	tree.add_fan(tags)
	return tree

static func actor_has(actor : Actor, tag_id : int) -> bool:
	return actor.tags.has(tag_id)

static func actor_not_has(actor : Actor, tag_id : int) -> bool:
	return actor.tags.not_has(tag_id)

static func actor_has_any(actor : Actor, tags : PackedInt32Array) -> bool:
	return actor.tags.has_any(tags)

static func actor_has_tree(actor : Actor, target : TagTree) -> bool:
	return actor.tags.has_tree(target)
