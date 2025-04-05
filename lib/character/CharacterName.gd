class_name CharacterName
extends Resource

static var ordinals : Array[StringName] = [
	"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"
]

static var human_given_names_male : Array[StringName] = [
	"James", "Michael", "Bob", "John", "David",
	"William", "Mason", "Johnny", "Thomas", 
	"Alvin", "Matthew", "Albert", "Mark", "Don",
	"Paul", "Andrew", "Joshua", "Kevin", "Brian",
	"George", "Ed", "Charles", "Frank", "Thomas",
]

static var human_given_names_female : Array[StringName] = [
	"Elizabeth", "Ada", "Emily", "Abby", "Sarah", "Megan",
	"Jessica", "Jenny", "Laura", "Mary", "Charlotte", 
	"Emma", "Olivia", "Sophie", "Ava", "Isabella",
	"Jennifer", "Maria", "Valentine", "Dorothy"
]

static var human_given_names : Array[StringName] = concat(
	human_given_names_male, human_given_names_female, [
		"Riley", "Ashley", "Chris", 
	#TODO: intent was to have these be available in both *_male and *_female arrays but this just doesnt do that
	# what was i cooking
])

static var human_surnames : Array[StringName] = [
	"Smith", "Johnson", "Williams", "Brown", "Jones",
	"Miller", "Gonzales", "Wilson", "Anderson", "Lee",
	"Taylor", "Moore", "Jackson", "Martin", "Thompson",
	"White", "Harris", "Sanchez", "Clark", "Robinson",
	"Lopez", "Walker", "Hall", "Young", "Allen",
	"King", "Wright", "Scott", "Torres", "Mitchell",
	"Adams", "Baker", "Nelson", "Carter", "Turner",
]

static var bot_models : Array[StringName] = [
	"BLACKTIDE", "OLYMPIC", "EVANS", "CAWESP", "CB-C",
	"IoEERIE", "KUANAN", "E7C", "KTMGK", "AVIE",
	"LOTTOK", "HYDRA", "PTAEK", "GATZ", "GARDEN"
]


static var bot_ordinals : Array[StringName] = concat(ordinals, [
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"
])

static var bee_given_names_male : Array[StringName] = [
	"Benjjamen", "Mikkal", "Jeke", "Jeb",
	"Cortor", "Carse", "Wilhelm", "Jebediah", 
	"Luka", "Jonas", "Able",
]

static var bee_given_names_female : Array[StringName] = [
	"Val", "Milk", "Mika", "Honey",
	"Rose", "Lilly", "Daisy", 
	"Jasmine", "Violet", "Iris", 
]

static var bee_given_names : Array[StringName] = concat(
	bee_given_names_male, bee_given_names_female, [
	"Andes", "Miik", "Cy", "Bezza",
])

static var bee_surnames : Array[StringName] = [
	"Honey", "Wing", "Nelar", "Combs", 
	"Wox", "Sturk", "Haven", "Bexx",
	"Boa", "Strong", "Erspe", "Harne",
	"Fry", "Ant", "Bay", "Isset",
	"Lanna", "Poepa", "Deen", "Waker",
]

static var fish_names : Array[StringName] = [
	"Freye", "Gobba", "Bati", "Tegra",
	"Tollo", "Besseme", "Dalm", "Cod",
	"Snatter", "Guope", "Mal", "Tuune",
	"Finn", "Soradeni", "Onvahy", "Kupp",
	"Marli", "Swish", "Sparb", "Meep",
	"Bubba", "Bub", "Lugi",
]

static var crab_names : Array[StringName] = [
	"Crust", "Crest", "Tchell", "Tchellr",
	"Tanct", "Tanctr", "Cle", "Cler", "Clerc",
	"Champ", "Scetl", "Scetlr", "Claw", "Clawr", 
	"Gabe", "Spip", "Spir", "Tap", "Tapr", "Eciks",
	"Eciksr", "Yel", "Yelr", "Yeld",
]

static var fungus_names : Array[StringName] = [
	"Feng", "Miroos", "Bold", "Sgoge",
	"Slem", "Mybim", "Nenkai", "Myke",
	"Hyhae", "Captain", "Stripe", "Gillis",
	"Basidi", "Chet", "Myro", "Yanni",
	"Monbe", "Shuu", "Looh", "Dreatus",
	"Walgoo", "Corba", "Widda", "Mob",
	"Bulbo",
]

static var lizard_names : Array[StringName] = [
	"Zerra", "Acrid", "Rerad", "Taerta",
	"Emerek", "Daedal", "Faellena", "Skier",
	"Viseke", "Monster", "Enetinn", "Kuqarra",
	"Avarani", "Koji", "Korr", "Karra",
	"Hassah", "Musta", "Narg", "Nerra",
	"Renn", "Rakk", "Igg", "Iviit",
	"Peikiis", "Distert", "Lakkor", "Gliesse",
	"Vek", "Vekka", "Vekki", "Vekko",
] 

static var moth_given_names : Array[StringName] = [
	"Ztiel", "Zophie", "Mezon", "Azhel", "Chompz",
	"Atejj", "Inor", "Lukaz", "Nallow", "Jelhelja",
	"Ikezk", "Tizzt", "Volloz", "Jollo", "Fjaal",
	"Marz", "Lejzzar", "Kuzzajj", "Zono", "Zakter",
	"Frezo", "Vruze", "Izavella", "Majzia", "Therzk",
	"Mekz", "Ezza", "Vozza", "Voaz", "Vazli", "Jompz",
	"Zaji", "Jenkt", "Anezzo", "Zejj", "Mykej",
]

static var plant_names : Array[StringName] = [
	"Vini", "Laffe", "Pelati", "Roto",
	"Bud", "Ptem", "Tahoni", "Creed",
	"Ptore", "Bliim", "Ftorei", "Fhaun",
	"Pfane", "Ross", "Lark", "Wodo",
	"Wogi", "Twogi", "Bollen", "Sptari",
	"Faed", "Fhale", "Dali", "Erada",
	"Wtilli", "Willow", "Rose", "Glaus",
	"Liy" 
]

static var adjectives_title : Array[StringName] = [
	"Brave", "Noble", "Swift", "Mighty", "Fearless",
	"Bold", "Feeble", "Sorry", "Sad", "Weak", "Prey",
	"Fool", "Fallen", "Lost", "Wretched", "Abandoned",
	"Forsaken", "Cursed", "Banished"
]

static var adjectives_nature : Array[StringName] = [
	"Plenty", "Thirsty", "Bloomed", "Flowering", "Fruiting",
	"Fallen", "Burning", "Frozen", "Withering",
	"Green", "Red", "Blue", "Black"
]

static var adjectives_metal : Array[StringName] = [
	"Iron", "Steel", "Copper", "Gold", "Silver",
	"Platinum", "Titanium", "Dense", "Light", "Heavy",
	"Thick", "Thin"
]

static var adjectives_ocean : Array[StringName] = [
	"Deep", "Wide", "Narrow", "Calm",
	"Rough", "Serene", "Choppy", 
	"Dark", "Bright", "Clear",
]

static func concat(arg1 : Array = [], arg2 : Array = [], arg3 : Array = [], arg4 : Array = [], arg5 : Array = [], arg6 : Array = [], arg7 : Array = [], arg8 : Array = [], arg9 : Array = [], arg10 : Array = [], arg11 : Array = []) -> Array[StringName]:
	var output : Array[StringName] = []
	for argument in [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11]:
		if argument is Array:
			for e in argument:
				if e is StringName or e is String:
					output.append(e)
	return output

static func convert_to_tronymics_fish(names : Array[StringName]) -> Array[StringName]:
	var tronymics : Array[StringName] = []
	tronymics.assign(names.map(func (n : StringName) -> StringName:
		return n + ["olb","mol","abal","emi"][ProjectHammer.weighted_random_index(5, 5, 1, 1)]
	))
	return tronymics

static func convert_to_tronymics_plant(names : Array[StringName]) -> Array[StringName]:
	var tronymics : Array[StringName] = []
	tronymics.assign(names.map(func (n : StringName) -> StringName:
		return n + ["a", "i", "o"][ProjectHammer.weighted_random_index(5, 3, 1)]
	))
	return tronymics

static func phonetic_adaptation_to_moth(names : Array[StringName]) -> Array[StringName]:
	var tronymics : Array[StringName] = []
	tronymics.assign(names.map(func (n : StringName) -> StringName:
		return n.replace("s", "z").replace("S", "Z").replace("d", "t").replace("D", "T")\
				.replace("b", "j").replace("B", "J").replace("g", "j").replace("G", "J")\
				.replace("c", "k").replace("C", "K")\
				.to_pascal_case()
	))
	return tronymics

static func generate(character : Character) -> String:
	var form_string : StringName = ""
	var fills_dictionary : Dictionary = {}
	match(character.race):
		Character.Race.HUMAN:
			form_string = [
				"<given> <surname>",
				"<given> <alternate> <surname>",
				"<given> the <adjective>(title)",
			][ProjectHammer.weighted_random_index(5, 2, 1)]
			fills_dictionary = {
				"<surname>": human_surnames,
				"<alternate>": human_given_names,
				"<adjective>(title)": adjectives_title,
			}
			match(character.gender):
				"M": fills_dictionary["<given>"] = human_given_names_male
				"F" : fills_dictionary["<given>"] = human_given_names_female
				_: fills_dictionary["<given>"] = human_given_names
		Character.Race.BORG:
			form_string = [
				"<model> <ordinal>",
				"<model> <given>-<ordinal>",
				"<model> <given>",
				"<model> <given> the <adjective>(metal)",
				"<given> the <adjective>(metal)",
				"<given> <surname>",
			][ProjectHammer.weighted_random_index(5, 5, 4, 3, 2, 1)]
			fills_dictionary = {
				"<model>": bot_models,
				"<given>": human_given_names,
				"<ordinal>": bot_ordinals,
				"<adjective>(metal)": adjectives_metal,
				"<surname>": human_surnames + adjectives_metal,
			}
		Character.Race.BEE:
			form_string = [
				"<surname> <given>-<ordinal>",
				"<surname> <given>",
				"<surname>, <adjective> <given>",
				"<adjective>",
			][ProjectHammer.weighted_random_index(7, 7, 5, 1)]
			fills_dictionary = {
				"<surname>": bee_surnames,
				"<ordinal>": ordinals,
				"<adjective>": adjectives_nature,
			}
			match(character.gender):
				"M": fills_dictionary["<given>"] = bee_given_names_male
				"F" : fills_dictionary["<given>"] = bee_given_names_female
				_: fills_dictionary["<given>"] = bee_given_names
		Character.Race.CRAB:
			form_string = [
				 "<given>(crab) <given>(crab)",
				 "<given>(fish) <given>(crab)",
				 "<given>(crab) <given>(fish)",
				 "<given>(crab) the <adjective>",
				 "<given>(crab) the <adjective> <given>(fish)",
				 "The <adjective> <given>(fish) <given>(crab)",
			][ProjectHammer.weighted_random_index(4, 4, 4, 4, 2, 2)]
			fills_dictionary = {
				"<given>(crab)": crab_names,
				"<given>(fish)": fish_names,
				"<adjective>": concat(adjectives_metal, adjectives_ocean, adjectives_title)
			}
		Character.Race.FISH:
			form_string = [
				 "<tronymic> <given>",
				 "<tronymic> <given>",
				 "<tronymic> <surname>",
				 "<tronymic> the <adjective>",
				 "<given> the <adjective> <tronymic>",
				 "The <adjective> <tronymic> <given>",
			][ProjectHammer.weighted_random_index(6, 4, 2, 2, 1, 1)]
			fills_dictionary = {
				"<given>": fish_names,
				"<tronymic>": convert_to_tronymics_fish(fish_names),
				"<surname>": fungus_names,
				"<adjective>": adjectives_ocean,
			}
		Character.Race.FUNGUS:
			form_string = [
				"<given> <surname>",
				"<given> the <adjective>",
			][ProjectHammer.weighted_random_index(5, 2)]
			fills_dictionary = {
				"<given>": fungus_names,
				"<surname>": fungus_names,
				"<adjective>": adjectives_nature + adjectives_title,
			}
		Character.Race.LIZARD:
			form_string = [
				"<given> <surname>",
				"<given> the <adjective>",
			][ProjectHammer.weighted_random_index(5, 2)]
			fills_dictionary = {
				"<given>": lizard_names,
				"<surname>": lizard_names,
				"<adjective>": adjectives_title,
			}
		Character.Race.MOTH:
			form_string = [
				"<given> <given> <given>",
				"<given> <given> <given>(lizard)",
				"<given> <given>(lizard) <given>",
				"<given> <given>(plant) <given>",
				"<given> <given>(human) <given>",
				"<given> <given>(crab) <given>",
			][ProjectHammer.weighted_random_index(9, 3, 2, 1, 1, 1)]
			fills_dictionary = {
				"<given>": moth_given_names,
				"<given>(lizard)": phonetic_adaptation_to_moth(lizard_names), #TODO: more races should do this
				"<given>(human)": phonetic_adaptation_to_moth(human_given_names),
				"<given>(plant)": phonetic_adaptation_to_moth(plant_names),
				"<given>(crab)": phonetic_adaptation_to_moth(crab_names),
			}
		Character.Race.PLANT:
			form_string = [
				"<given> <tronymic> <surname>(human)",
				"<given>(human) <given> <surname>(human)",
				"<given>(human) <given> <tronymic>",
				"<given> <surname>(human) <tronymic>",
				"<adjective> <tronymic> <given>",
				"<given> <given>",
				"<given> <tronymic> the <adjective>",
				"<given> the <adjective> <given>(human) <tronymic>",
			][ProjectHammer.weighted_random_index(8, 3, 3, 3, 5, 4, 2, 3)]
			fills_dictionary = {
				"<adjective>": adjectives_nature,
				"<tronymic>": convert_to_tronymics_plant(plant_names),
				"<given>": plant_names,
				"<surname>(human)": human_surnames,
			}
			match(character.gender):
				"M": fills_dictionary["<given>(human)"] = human_given_names_male
				"F" : fills_dictionary["<given>(human)"] = human_given_names_female
				_: fills_dictionary["<given>(human)"] = human_given_names
	return format(form_string, fills_dictionary)

static func format(name_string : String, fills_dictionary : Dictionary) -> String:
	var sections : Array[String] = []
	sections.assign(ProjectHammer.string_multi_split(name_string, [" ", "-", ":", ","], false))
	var formatted_sections : Array[String] = []
	for section in sections:
		var formatted : String = section
		if section.contains("<") and section.contains(">"):
			var options : Array[StringName] = []
			options.assign(fills_dictionary.get(section, []))
			if not options.is_empty():
				formatted = options.pick_random()
			else:
				formatted = section.to_upper()
		formatted_sections.append(formatted)
	var result : String = " ".join(formatted_sections)
	return result
	