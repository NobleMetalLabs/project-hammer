class_name GameEvent
extends Resource

class SpeakToPerson extends GameEvent:
	var person : Character = null

class CrewUpdate extends GameEvent:
	var crew_member : Crewmember

#types:
# - Perform <action> multiple times
# 	- Travel to <place>
# 		- Escort <person> to <place>
# 		- Explore <area>
# 	- Speak to <person>
# 		- Rescue <person>
# 		- Deliver <thing> to <person/place>
# 	- Obtain <thing>
# 		- Build or craft <thing>
# 		- Gather <resources>
# 	- Something happen to <crew>
# 		- Recruit <person>
# 	- Complete <NarrativeChunk> with <outcome>
# 		- Hack/disable <device>
# 		- Defend <place/person>
# 		- Investigate <mystery/event>
# 		- Use <item> at <place>
# 		- Solve <puzzle>
