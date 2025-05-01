class_name Producer
extends Node

@export var recipe : ProductionRecipe

func _ready() -> void:
	recipe.ingredients[ItemDB.Item.ORE] = 4
	recipe.products[ItemDB.Item.CONSTRUCTION_MATERIALS] = 7
