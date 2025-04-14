class_name Crewmember
extends Resource

enum Role {
	COMMAND,
	ENGINEERING,
	DECK,
	MEDICAL,
	SCIENCE,
	ARMS,
}

var roles : Array[Role] = []
var character : Character = Character.new()

