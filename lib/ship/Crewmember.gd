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

const skill_weights = {
	#					ATL CRM PRC CFT LRE SOC IGN PSN
	Role.COMMAND: 		[0,	0,	1,	0,	.3,	1,	0,	1],
	Role.ENGINEERING:	[0,	0,	0,	0,	0,	0,	0,	0],
	Role.DECK:			[0,	0,	0,	0,	0,	0,	0,	0],
	Role.MEDICAL:		[0,	0,	0,	0,	0,	0,	0,	0],
	Role.SCIENCE:		[0,	0,	0,	0,	0,	0,	0,	0],
	Role.ARMS:			[0,	0,	0,	0,	0,	0,	0,	0],
}
# Command: Presence, society, perception, lore(?)
# Engineering/science: Craftsmanship, ingenuity, perception
# Deck (Nav): Perception, athletics (i.e. quick thinking??)
