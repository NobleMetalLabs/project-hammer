class_name Skills
extends Resource

enum Skill {
	ATHLETICS,
	CRIME,
	PERCEPTION,
	CRAFTSMANSHIP,
	LORE,
	SOCIETY,
	INGENUITY,
	PRESENCE,
}

var _values : Dictionary = {} #[Skill, float]

func _init(random : bool = true) -> void:
	if random:
		var values : Array[float] = [
			1,
			1,
			0.5,
			0.5,
			0.5,
			0,
			0,
			0,
		]
		values.shuffle()
		for i in range(0, values.size()):
			_values[Skill.values()[i]] = values[i]

func get_skill_value(skill : Skill) -> float:
	return _values.get(skill, 0.0)

func get_skill_value_dictionary() -> Dictionary:
	var output : Dictionary = {}
	for skill in Skill.values():
		output[Skill.keys()[skill]] = _values.get(skill, 0.0)
	return output

func adjust_skill_value(skill : Skill, value : float) -> void:
	_values[skill] = _values.get(skill, 0.0) + value