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
		_values[Skill.ATHLETICS] = randf_range(-1, 1)
		_values[Skill.CRIME] = randf_range(-1, 1)
		_values[Skill.PERCEPTION] = randf_range(-1, 1)
		_values[Skill.CRAFTSMANSHIP] = randf_range(-1, 1)
		_values[Skill.LORE] = randf_range(-1, 1)
		_values[Skill.SOCIETY] = randf_range(-1, 1)
		_values[Skill.INGENUITY] = randf_range(-1, 1)
		_values[Skill.PRESENCE] = randf_range(-1, 1)

func get_skill_value(skill : Skill) -> float:
	return _values.get(skill, 0.0)

func adjust_skill_value(skill : Skill, value : float) -> void:
	_values[skill] = _values.get(skill, 0.0) + value