class_name Ship
extends Resource

var name : StringName
var hull_structure : HullStructure
var installed_systems : Array[InstalledSystem]
var installed_augments : Array[InstalledAugment]

var onboard_crew : Array[Crewmember]
var onboard_cargo : Array[Cargo]
var onboard_passengers : Array[Passenger]