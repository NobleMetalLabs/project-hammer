class_name NarrativeEditorMenuBar
extends MenuBar

var menus : Dictionary = {} #[PopupMenu, name]

signal menu_selected(path : String)

func _ready():
	for child in get_children():
		if child is PopupMenu:
			menus[child] = child.name
			child.id_pressed.connect((func handle_pressed(id, menu):
				var path = "%s/%s" % [menus[menu].to_lower(), menu.get_item_text(id).to_lower()]
				menu_selected.emit(path)
			).bind(child))

