class_name ProductionStatus
extends Resource

@export var conversion : GoodConversion
@export var reserves : Array[Reserve] = []
@export var efficiency : float = 1.0
@export var production_goal : float
@export var maximum_production : float
@export var current_production : float
