extends Control

func _ready():
	var line := Line2D.new()
	self.add_child(line)
	line.points = [
		Vector2(0, 0),
		self.size,
	]