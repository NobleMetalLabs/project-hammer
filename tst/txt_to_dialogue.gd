extends Node

@export_file("*.txt") var text_file : String
@export_dir var output_dir : String = "res://ast/dialogue/"

var output : DialoguePart = null

func _ready():
	var file := FileAccess.open(text_file, FileAccess.READ)
	if file.get_error() != Error.OK: return
	var plaintext : String = FileAccess.open(text_file, FileAccess.READ).get_as_text()
	
	#plaintext = plaintext.dedent()
	var lines : Array = plaintext.split("\r\n")
	lines = lines.filter(func(line : String): return line != "")
	lines = lines.map(func(line : String): return line.lstrip("\t"))

	output = parse_lines(lines)
	

func parse_lines(lines : Array, previous_part : DialoguePart = null) -> DialoguePart:
	if lines.size() == 0: return null
	var working_line : String = lines.pop_front()
	print("Parsing Line \"%s\"" % working_line)
	if working_line.begins_with("<"):
		var dp : DialoguePart = CommandDialoguePart.new()
		dp.command = working_line.trim_prefix("<").trim_suffix(">")
		previous_part.next = dp
		parse_lines(lines.duplicate(), dp)
		return dp
	elif working_line.get_slice(".", 0).is_valid_int():
		var new_lines : Array = lines.duplicate()
		while not new_lines.front().begins_with("#"): new_lines.pop_front()
		new_lines.pop_front()
		previous_part.choices[working_line] = parse_lines(new_lines)
		parse_lines(lines.duplicate(), previous_part)
		return previous_part
	elif working_line.begins_with("#"):
		return null
	else:
		if previous_part != null:
			previous_part.text += "\n" + working_line
			return parse_lines(lines.duplicate(), previous_part)
		else:
			var current_dp : DialoguePart = SpokenDialoguePart.new()
			current_dp.text = working_line
			parse_lines(lines.duplicate(), current_dp)
			return current_dp
