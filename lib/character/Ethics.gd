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
			0.25,
			0.25,
			0.0,
			0.0,
			0,
			0,
			-0.125,
			-0.5,
		]
		#values.assign(values.map(func (f : float) -> float: return f + randf_range(-0.125, 0.125)))
		values.assign(values.map(snappedf.bind(0.0625)))
		values.assign(values.map(clampf.bind(-1, 1)))
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
