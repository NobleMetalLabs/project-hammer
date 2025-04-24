extends Node

func _ready():
	var t := Actor.new()

	t.tags.add_chain([1, 2, 3])
	t.tags.add_tag(4)
	t.tags.add_chain([5, 6])
	t.tags.deep().add_fan([7, 8])
	t.tags.add_tag(9)
	print()
	print(t.tags)