class_name DialoguePart
extends Serializeable

var text : String = ""
var command : String = ""
var choices : Dictionary = {} # [String : DialoguePart]
