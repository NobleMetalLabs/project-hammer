class_name CharacterName
extends Resource

static var human_first_names : Array[StringName] = ["James", "Michael", "Robert", "John", "David", "William", "Richard", "Joseph", "Thomas", "Chris"]
static var human_last_names : Array[StringName] = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Gonzales", "Wilson", "Anderson", "Lee"]


static func generate(char : Character) -> String:
	
	
	match(char.race):
		Character.Race.HUMAN: return "%s %s" % [human_first_names.pick_random(), human_last_names.pick_random()]
		_: return "my b"

#    Form Factors
#1 - Given Alt Surname  - Preferred by Humans
#2 - Given Occupation
#3 - Given Ancestral
#4 - Given the Noun/Title/Thing
#5 - Given the Adjective (Occupation?)
#6 - Given
#7 - Given of Location
