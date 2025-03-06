class_name UISystemsTreeItem
extends Control

@onready var header_button : Button = self.find_child("HEADER-BUTTON", true, false)
@onready var header_label : Label = self.find_child("HEADER-LABEL", true, false)

@onready var info_items_section : BoxContainer = self.find_child("INFO-ITEMS-SECTION", true, false)
@onready var info_item_label : Label = self.find_child("INFO-ITEM-LABEL", true, false)
@onready var info_item_value : Label = self.find_child("INFO-ITEM-VALUE", true, false)

@onready var manual_eff_slider : Slider = self.find_child("MANUAL-EFF-SLIDER", true, false)

var _info_item_labels : Dictionary = {} #[StringName, Label]
var _info_item_values : Dictionary = {} #[StringName, Label]

func _ready():
	info_items_section.visible = false
	header_button.pressed.connect(func():
		info_items_section.visible = not info_items_section.visible
	)

	info_item_label.visible = false
	info_item_value.visible = false

func set_header_text(text : String) -> void:
	header_label.text = text

func set_system_info(inst_system : InstalledSystem) -> void:
	manual_eff_slider.value = inst_system.manual_efficiency * 100
	

	for modified_stat : ProjectHammer.CraftStatistic in inst_system.system.modifies_stats:
		var mods : Array[StatMod] = inst_system.system.get_stat_modifications(modified_stat, inst_system, ShipManager.ship)
		var stats : Array = mods.map(func(mod : StatMod) -> String: return mod.as_statline() + ProjectHammer.craft_stat_units(modified_stat))
		var statline : String = ", ".join(stats)
		self.set_info_item(ProjectHammer.craft_stat_string(modified_stat), statline)

func set_info_item(key : String, value : String) -> void:
	var item_label : Label = _info_item_labels.get(key, null)
	if item_label == null:
		item_label = info_item_label.duplicate()
		item_label.visible = true
		info_item_label.add_sibling(item_label)
		_info_item_labels[key] = item_label
	item_label.text = key

	var item_value : Label = _info_item_values.get(key, null)
	if item_value == null:
		item_value = info_item_value.duplicate()
		item_value.visible = true
		info_item_value.add_sibling(item_value)
		_info_item_values[key] = item_value
	item_value.text = value

func remove_info_item(key : String) -> void:
	var item_label : Label = _info_item_labels.get(key, null)
	if item_label != null: item_label.queue_free()
	_info_item_labels.erase(key)

	var item_value : Label = _info_item_values.get(key, null)
	if item_value != null: item_value.queue_free()
	_info_item_values.erase(key)
