class_name Character
extends Taggable

var name : String = ""
var race : Race = Race.HUMAN
var gender : StringName = "N"
var faction : FactionDB.Faction = FactionDB.Faction.UNAFFILIATED
var ethics : Ethics = Ethics.new()
var mental_health : MentalHealth = MentalHealth.new()
var skills : Skills = Skills.new()
var wallet : Wallet = Wallet.new()

enum Race {
	HUMAN,
	BORG,
	BEE,
	CRAB,
	FISH,
	FUNGUS,
	LIZARD,
	MOTH,
	PLANT,
}

func _init(random : bool = true) -> void:
	if random:
		race = Race.values().pick_random()
		name = CharacterName.generate(self)
