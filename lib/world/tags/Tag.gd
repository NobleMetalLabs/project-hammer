class_name Tag
extends RefCounted

func equals(other : Tag) -> bool:
	var type = self.get_script().get_global_name()
	if type != other.get_script().get_global_name(): return false
	if self is EnumTag:
		return self.value == other.value
	
	return false


# TODO:
# tag brainstorm --- 03/24/2025
#
# "hidden information tag"
# has a callable(?) and array of tags, callable returns if the information is visible or not
# we figure that out later when gameevent is matured
# what could be hidden?
# function for locations, status/skills for characters, faction for events?, 
# 
# + related idea, narrativechunks should and will have hidden choices (e.g. skillcheck / other)
#
# ethics tags somehow
# may be used for places / events / characters
#
# character traits? below
# skills
# will probably not be tags anyway, probably will be in lib/character/Skills.gd
# athletics, crime, perception, diplomacy, craftsmanship, lore, society, presence
#
# luh mental illness that affects ethics or something
# status - fame or perhaps even infamy - could be good or bad
