class_name UISystemsTree
extends Control

var _inst_system_to_tree_item : Dictionary = {} #[InstalledSystem, UISystemsTreeItem]
@onready var tree_item_template : Control = $"%SYSTEM-TREE-ITEM"

func _ready():
	tree_item_template.visible = false
	update_tree()
	
	ProjectHammerEventBus.subscribe("ship/installed_systems_changed", update_tree)

func update_tree(_data : Dictionary = {}):
	for inst_system in ShipManager.ship.installed_systems:
		if not _inst_system_to_tree_item.has(inst_system):
			var sys_item : UISystemsTreeItem = tree_item_template.duplicate()
			tree_item_template.add_sibling(sys_item)
			sys_item.visible = true
			var sys_pos : Vector3i = inst_system.region.to_AABB().get_center()
			sys_item.set_header_text("%s @ <%s>" %[inst_system.system.name, str(sys_pos).left(-1).right(-1)])
			_inst_system_to_tree_item[inst_system] = sys_item
			sys_item.set_system_info(inst_system)