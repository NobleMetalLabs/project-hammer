class_name WorldSector
extends Actor

var name : String = ""
var locations : Array[SectorLocation] = []
var locations_with_sublocations : Array[SectorLocation] :
	get:
		var output : Array[SectorLocation] = []
		for location in locations:
			output.append_array(location.sublocations)
		output.append_array(locations)
		return output
