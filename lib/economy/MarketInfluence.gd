class_name MarketInfluence
extends Resource

enum InfluenceType {
	SUPPLY,
	DEMAND,
	RESERVE,
}

@export var influence_type : InfluenceType
@export var market : ItemDB.Item # TODO: should eventually be something else probably
@export var value : float = 1.0
