class_name Ship
extends Resource

@export var name : StringName
@export var hull_structure : HullStructure
@export var installed_systems : Array[InstalledSystem]
@export var installed_augments : Array[InstalledAugment]

@export var onboard_crew : Array[Crewmember]
@export var onboard_cargo : Array[Cargo]
@export var onboard_passengers : Array[Passenger]