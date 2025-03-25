class_name ItemDB
extends RefCounted

enum Item {
	FOOD,
	WATER,
	ORE,
	CONSTRUCTION_MATERIALS,
	WEAPONS,
	TOOLS,
	SCIENCE,
	MEDICINE,
	INDUSTRIAL_GOODS,
	TECHNOLOGY,
	VEHICLES,
	ART,
}

static func item_string(item : Item) -> StringName:
	return Item.keys()[item]

static func item_from_string(item : StringName) -> Item:
	return Item.keys().find(item.to_upper()) as Item
