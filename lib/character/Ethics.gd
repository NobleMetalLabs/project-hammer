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
		var values : Array[float] = [
			1,
			1,
			1,
			0.5,
			0,
			0,
			0,
			-0.5,
			-1,
		]
		values.shuffle()
		for i in range(0, values.size()):
			_values[Principle.values()[i]] = values[i]

func get_principle_value(principle : Principle) -> float:
	return _values.get(principle, 0.0)

func get_principle_value_dictionary() -> Dictionary:
	var output : Dictionary = {}
	for principle in Principle.values():
		output[Principle.keys()[principle]] = _values.get(principle, 0.0)
	return output

func adjust_principle_value(principle : Principle, value : float) -> void:
	_values[principle] = _values.get(principle, 0.0) + value