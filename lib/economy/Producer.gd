class_name Producer
extends Node

@export var production_status : ProductionStatus

func _ready() -> void:
	production_status.ingredient_requirements[ItemDB.Item.ORE] = 4
	production_status.product_goals[ItemDB.Item.CONSTRUCTION_MATERIALS] = 7
