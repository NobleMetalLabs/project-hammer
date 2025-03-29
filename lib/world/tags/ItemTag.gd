class_name ItemTag
extends EnumTag

func _init(item : ItemDB.Item) -> void:
	self.value = item

func _to_string() -> String:
	return "ItemTag<%s>" % ItemDB.item_string(self.value)