class_name Character
extends Resource

var name : String = ""
var faction : FactionDB.Faction
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
