class_name Ethics
extends Resource

enum Principle {
	AUTONOMY,
	DECENCY,
	EMPATHY,
	HONESTY,
	JUSTICE,
	LOYALTY,
	PRAGMATISM,
	RESPECT,
	SELFLESSNESS,
}

var _values : Dictionary = {} #[Principle, float]

func _init(random : bool = true) -> void:
	if random:
		_values[Principle.AUTONOMY] = randf_range(-1, 1)
		_values[Principle.DECENCY] = randf_range(-1, 1)
		_values[Principle.EMPATHY] = randf_range(-1, 1)
		_values[Principle.HONESTY] = randf_range(-1, 1)
		_values[Principle.JUSTICE] = randf_range(-1, 1)
		_values[Principle.LOYALTY] = randf_range(-1, 1)
		_values[Principle.PRAGMATISM] = randf_range(-1, 1)
		_values[Principle.RESPECT] = randf_range(-1, 1)
		_values[Principle.SELFLESSNESS] = randf_range(-1, 1)

func get_principle_value(principle : Principle) -> float:
	return _values.get(principle, 0.0)

func adjust_principle_value(principle : Principle, value : float) -> void:
	_values[principle] = _values.get(principle, 0.0) + value